package haxium;

import haxium.Device;
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
		Log.trace('\n88  88    db    Yb  dP 88 88   88 8b    d8 ', Red);
		Log.trace('88  88   dPYb    YbdP  88 88   88 88b  d88 ', Red);
		Log.trace('888888  dP__Yb   dPYb  88 Y8   8P 88YbdP88 ', Red);
		Log.trace('88  88 dP""""Yb dP  Yb 88  YbodP  88 YY 88 ', Red);
		Log.trace('\n[Server] ----------------------------------\n', Cyan);
		this.port = port;
	}

	public function readCommand():Command
	{
		return Protocol.readCommand(remote.input);
	}

	public function writeCommand(command:Command)
	{
		return Protocol.writeCommand(remote.output, command);
	}

	public function listen(whenConnected:Device->Void)
	{
		Log.trace("Listening for Haxe client connection ...", Cyan);
		while (true)
		{
			var socket = waitForConnection();
			Log.trace("Device connected " + socket.peer().host.ip, Cyan);
			Device.create(this, socket, whenConnected);
		}
	}

	public function waitForConnection():Socket
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

		var socket : sys.net.Socket = null;
		while (true)
		{
			while (socket == null)
			{
				try
				{
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
			Log.trace("Received connection from " + peer.host + ".", Default);
			remote = socket;
			break;
		}

		return socket;
	}
}
