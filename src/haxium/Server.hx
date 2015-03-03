package haxium;

import haxium.protocol.Command;
import haxium.protocol.Protocol;
import haxium.util.Log;
import sys.net.Host;
import sys.net.Socket;
#if neko
import neko.vm.Thread;
#elseif cpp
import cpp.vm.Thread;
#end


class Server
{
	public var port(default, null):Int;
	public var input(default, null):Protocol;
	public var output(default, null):Protocol;
	public var remote(default, null):Socket;

	public var listenSocket:Socket;
	
	public function new(port:Int)
	{
		this.port = port;
		waitForConnection();
	}

	public function readCommand():Command
	{
		return Protocol.readCommand(remote.input);
	}

	public function writeCommand(command:Command)
	{
		return Protocol.writeCommand(remote.output, command);
	}

	function waitForConnection()
	{
		while (listenSocket == null)
		{
			listenSocket = new Socket();
			try
			{
				var host = new Host(Host.localhost());
				Sys.println(host);
				listenSocket.bind(host, port);
				listenSocket.listen(10);
			}
			catch (e:Dynamic)
			{
				Log.trace("Failed to bind/listen on port " + 
                            port + ": " + e, Cyan);
                Log.trace("Trying again in 3 seconds.", Cyan);
                Sys.sleep(3);
                listenSocket.close();
                listenSocket = null;
			}
		}

		while (true)
		{
			var socket : sys.net.Socket = null;
			while (socket == null)
			{
				try
				{
					Log.trace("Listening for Haxe client connection ...", Cyan);
					socket = listenSocket.accept();
				}
				catch (e : Dynamic)
				{
					Log.trace("Failed to accept connection on port " 
						+ port + ": " + e, Cyan);
					Log.trace("Trying again in 1 second.", Cyan);
					Sys.sleep(5);
				}
			}
			var peer = socket.peer();
			Log.trace("Received connection from " + peer.host + ".", Cyan);
			remote = socket;
			break;
		}
	}
}
