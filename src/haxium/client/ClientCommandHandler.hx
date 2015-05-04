package haxium.client;

import haxe.io.Input;
import haxe.Timer;
import haxium.handler.IHandler;
import haxium.protocol.command.Command;
import haxium.protocol.command.ElementFilter;
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
		trace("listen");
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
			trace('message');
			var handled = false;
			var result = handleCommand(message);
			
			if (result == null) Log.trace('Unhandled message $message', Red);
		}
	}

	function handleCommand(command:Null<Command>):Dynamic
	{
		var result:Dynamic = null;
		var child:Dynamic;
		var handled:Bool;
		var filter:ElementFilter;
		for (handler in handlers)
		{
			result = switch (command)
			{
				case Command.GetProperty(childName, name):
					filter = ElementFilter.ElementId(childName);
					child = handler.getChild(filter);
					handler.getProperty(child[0], name);

				case Command.SetProperty(childName, name, value):
					filter = ElementFilter.ElementId(childName);
					child = handler.getChild(filter);
					handler.setProperty(child[0], name, value);

				case Command.GetChild(by):
					result = handler.getChild(by);

				case Command.GetBounds(childName):
					filter = ElementFilter.ElementId(childName);
					child = handler.getChild(filter);
					result = handler.getChildBounds(child[0]);

				case _:
			
			};
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
