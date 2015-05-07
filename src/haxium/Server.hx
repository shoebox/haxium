package haxium;

import android.monkey.MonkeyDevice;
import android.monkey.MonkeyRunner;
import haxium.Device;
import haxium.protocol.command.Command;
import haxium.protocol.command.ResponseCommand;
import haxium.protocol.Commander;
import haxium.util.Log;
import sys.net.Host;
import sys.net.Socket;
import haxium.util.Thread;

class Server
{
	public var port(default, null):Int;
	public var input(default, null):Commander;
	public var output(default, null):Commander;
	public var remote(default, null):Socket;
	
	public var listenSocket:Socket;
	
	public function new(port:Int)
	{
		Log.trace('\n', Red);
		Log.trace('88  88    db    Yb  dP 88 88   88 8b    d8 ', Red);
		Log.trace('88  88   dPYb    YbdP  88 88   88 88b  d88 ', Red);
		Log.trace('888888  dP__Yb   dPYb  88 Y8   8P 88YbdP88 ', Red);
		Log.trace('88  88 dP""""Yb dP  Yb 88  YbodP  88 YY 88 ', Red);
		Log.trace('\n[Server] ----------------------------------\n', Cyan);
		this.port = port;
	}

	public function readResponse():ResponseCommand
	{	
		var result = Commander.readResponseCommand(remote.input);
		return result;
	}

	public function readCommand():Dynamic
	{
		var result = Commander.readResponseCommand(remote.input);
		return result;
	}

	public function writeCommand(command:Dynamic)
	{
		Commander.writeCommand(remote.output, command);
	}

	public function listenForMonkey(whenMonkeyConnected:MonkeyDevice->Void)
	{
		MonkeyRunner.create(function(device:MonkeyDevice)
			{
				device.server = this;
				whenMonkeyConnected(device);
			}
		);
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
