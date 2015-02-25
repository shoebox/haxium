package haxium;

import sys.net.Host;
import sys.net.Socket;
import neko.vm.Thread;

class Server
{
	public var port(default, null):Int;

	var listenSocket:Socket;

	public function new(port:Int)
	{
		this.port = port;
		Thread.create(waitForConnection);
	}

	function waitForConnection()
	{
		while (listenSocket == null)
		{
			listenSocket = new Socket();
			try
			{
				var host = new Host("192.168.1.101");
				listenSocket.bind(host, port);
				listenSocket.listen(1);
			}
			catch (e:Dynamic)
			{
				Sys.println('\033[35m ' + "Failed to bind/listen on port " + 
                            port + ": " + e);
                Sys.println('\033[35m ' + "Trying again in 3 seconds.");
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
					Sys.println('\033[35m ' + "Listening for Haxe client connection ...");
					socket = listenSocket.accept();
				}
				catch (e : Dynamic)
				{
					Sys.println('\033[35m ' + "Failed to accept connection on port " +
					port + ": " + e);
					Sys.println('\033[35m ' + "Trying again in 1 second.");
					Sys.sleep(5);
				}
			}
			var peer = socket.peer();
			Sys.println('\033[35m ' + "\nReceived connection from " + peer.host + ".");
		}
	}
}
