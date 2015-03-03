package haxium;

import haxe.Timer;
import haxium.protocol.Protocol;
import haxium.protocol.Command;
import haxium.plugin.IHandler;
import haxium.util.Log;
import haxe.io.Input;
#if neko
import neko.vm.Deque;
import neko.vm.Thread;
#elseif cpp
import cpp.vm.Deque;
import cpp.vm.Thread;
#end

class ClientCommandHandler
{
	var client(default, null):Client;
	var thread:Thread;
	var timer:Timer;
	var handlers:Array<IHandler>;

	public function new(client:Client)	
	{
		this.client = client;
		handlers = [];
	}

	public function listen()
	{
		timer = new Timer(100);
		timer.run = checkForMessage;

		thread = Thread.create(threadedListener);
		thread.sendMessage(Thread.current());
		thread.sendMessage(client.socket.input);
	}

	function checkForMessage()
	{
		var message:Command = Thread.readMessage(false);
		if (message != null)
		{
			var handled:Bool = false;
			var result:HandlerResponse;
			for (handler in handlers)
			{
				result = handler.onMessage(message);
				if (result.handled)
				{
					if (result.command != null)
					{
						Protocol.writeDynamic(client.socket.output, result.command);	
					}
					handled = true;
					break;
				}
			}

			if (!handled) Log.trace("Unhandled message $message", Red);
		}
	}

	function threadedListener()
	{
		var mainThread:Thread = Thread.readMessage(true);
		var input:Input = Thread.readMessage(true);
		if (input == null) return;
		while (true)
		{
			var command:Command = Protocol.readCommand(input);
			if (command != null) mainThread.sendMessage(command);
			Sys.sleep(2);
		}
	}

	public function addHandler(handler:IHandler)
	{
		handlers.push(handler);
	}
}
