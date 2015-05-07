package haxium.client;

import haxe.io.Input;
import haxe.Timer;
import haxium.handler.IDevice.ITouchDevice;
import haxium.handler.IHandler;
import haxium.protocol.command.Command;
import haxium.protocol.command.ElementFilter;
import haxium.protocol.command.ResponseCommand;
import haxium.protocol.Commander;
import haxium.util.Log;
import haxium.util.Thread;

class ClientCommandHandler
{
	var client(default, null):Client;
	var thread:Thread;
	var timer:Timer;
	var handlers:Array<IHandler<Dynamic>>;

	public function new(client:Client)	
	{
		this.client = client;
		handlers = [];
	}

	public function listen()
	{
		timer = new Timer(1);
		timer.run = checkForMessage;

		thread = Thread.create(threadedListener);
		thread.sendMessage(Thread.current());
		thread.sendMessage(client.socket.input);
	}

	function checkForMessage()
	{
		var message:Dynamic = Thread.readMessage(false);
		if (message != null)
		{
			var handled = false;
			var result = handleCommand(message);
			
			if (result == null) Log.trace('Unhandled message $message', Red);
		}
	}

	function handleCommand(command:Null<Command>):ResponseCommand
	{
		var result:ResponseCommand = null;
		var child:Dynamic;
		var handled:Bool;
		var filter:ElementFilter;
		var id:String;
		for (handler in handlers)
		{
			switch (command)
			{
				case Command.GetProperty(childName, name):
					filter = ElementFilter.ElementId(childName);
					child = handler.getChild(filter);
					if (child.length == 0)
					{
						result = ResponseCommand.Invalid;
					}
					else
					{
						var property = handler.getProperty(child[0], name);
						result = ResponseCommand.GetProperty(property);
					}

				case Command.SetProperty(childName, name, value):
					filter = ElementFilter.ElementId(childName);
					child = handler.getChild(filter);
					if (child.length == 0)
					{
						result = ResponseCommand.Invalid;
					}
					else
					{
						result = handler.setProperty(child[0], name, value) 
							? ResponseCommand.Valid
							: ResponseCommand.Invalid;
					}

				case Command.GetChild(filter):
					var childs = handler.getChild(filter);
					var list = [];
					for (child in childs)
					{
						id = handler.getChildAutomationName(child);
						list.push(id);
					}
					result = GetChilds(list);

				case Command.GetBounds(childName):
					filter = ElementFilter.ElementId(childName);
					child = handler.getChild(filter);
					var bounds = handler.getChildBounds(child[0]);
					result = ResponseCommand.GetBounds(bounds);

				case _:
			
			};

			if (Std.is(handler, ITouchDevice))
			{
				var touchHandler:ITouchDevice = cast handler;
				switch (command)
				{
					case Command.Touch(x, y, type):
						result = touchHandler.touch(x, y, type) ? Valid : Invalid;

					default:
				}
			}
		}
		
		if (result != null)
		{
			Commander.writeDynamic(client.socket.output, result);
			handled = true;
		}
		
		return result;
	}

	function threadedListener()
	{
		var mainThread:Thread = Thread.readMessage(true);
		var input:Input = Thread.readMessage(true);
		if (input == null) return;
		var command:Command;
		while (true)
		{
			command = Commander.readCommand(input);
			if (command != null)
			{
				mainThread.sendMessage(command);
			}
			Sys.sleep(0.1);
		}
	}

	public function addHandler(handler:IHandler<Dynamic>)
	{
		handlers.push(handler);
	}
}
