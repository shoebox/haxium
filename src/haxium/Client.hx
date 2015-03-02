package haxium;

import haxium.Protocol;
import sys.net.Host;
import sys.net.Socket;

class Client
{
	public var host(default, null):String;
	public var port(default, null):Int;
	public var socket(default, null):Socket;
	public var handler(default, null):haxium.ClientCommandHandler;

	var protocol:Protocol;

	public function new(host:String, port:Int)
	{
		this.host = host;
		this.port = port;
		socket = new Socket();
	}

	public function connect()
	{
		var serverHost = new Host(host);
		var connected = false;
		while (!connected)
		{
			try
			{
				trace("trying");
				socket.connect(serverHost, port);
				trace("Connected to the Haxium server at " + host + ":" + port);
				connected = true;
				whenConnected();
				return;
			}
			catch (error:Dynamic)
			{
				trace("Failed to connect to debugging server at " +
							host + ":" + port + " : " + error);
			}
			Sys.println("Trying again in 10 seconds.");
			Sys.sleep(10);
		}
	}

	function whenConnected()
	{
		handler = new haxium.ClientCommandHandler(this);
	}
}
