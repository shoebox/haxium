package haxium;

import haxium.ClientCommandHandler;
import haxium.protocol.Protocol;
import haxium.plugin.IHandler;
import sys.net.Host;
import sys.net.Socket;

class Client
{
	public var host(default, null):String;
	public var port(default, null):Int;
	public var connected(default, null):Bool;
	public var socket(default, null):Socket;
	public var handler(default, null):ClientCommandHandler;

	var protocol:Protocol;

	public function new(host:String, port:Int)
	{
		this.host = host;
		this.port = port;
		socket = new Socket();
		handler = new ClientCommandHandler(this);
	}

	public function connect()
	{
		var serverHost = new Host(host);
		while (!connected)
		{
			try
			{
				trace("trying");
				socket.connect(serverHost, port);
				trace("Connected to the Haxium server at " + host + ":" + port);
				whenConnected();
				return;
			}
			catch (error:Dynamic)
			{
				trace(error);
				trace("Failed to connect to debugging server at " +
					host + ":" + port + " : " + error);
			}
			Sys.println("Trying again in 10 seconds.");
			Sys.sleep(10);
		}
	}

	public function addHandler(value:IHandler)
	{
		handler.addHandler(value);
	}

	function whenConnected()
	{
		connected = true;
		handler.listen();
	}
}
