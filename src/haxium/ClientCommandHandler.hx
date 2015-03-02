package haxium;

import haxium.Protocol;
#if neko
import neko.vm.Thread;
#elseif cpp
import cpp.vm.Thread;
#end

class ClientCommandHandler
{
	var client:Client;
	var thread:Thread;

	public function new(client:Client)	
	{
		thread = Thread.create(threadedListener);
		thread.sendMessage(client);
	}

	function listen()
	{

	}

	function threadedListener()
	{
		var client = Thread.readMessage(true);
		while (true)
		{
			var command = Protocol.readCommand(client.socket.input);
			trace(command);
			Sys.sleep(2);
		}
	}
}
