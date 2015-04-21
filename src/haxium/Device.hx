package haxium;

import haxium.protocol.Command;
import haxium.protocol.DeviceCommand.Click;
import haxium.protocol.Elements;
import neko.vm.Thread;
import sys.net.Socket;

class Device
{
	public var socket(default, null):Socket;
	public var server(default, null):Server;
	public var elements(default, null):Elements;

	function new(server:Server, socket:Socket)
	{
		this.server = server;
		this.socket = socket;
		this.elements = new Elements(server, this);
	}

	public function touch(stageX:Int, stageY:Int)
	{
		var deviceCommand = Click(stageX, stageY);
		var command = Command.DeviceAction(deviceCommand);
		server.writeCommand(command);

		var response = server.readCommand();
	}

	public static function create(server:Server, socket:Socket, whenConnected:Device->Void)
	{
		var thread = Thread.create(build);
		thread.sendMessage(server);
		thread.sendMessage(socket);
		thread.sendMessage(whenConnected);
	}

	static function build()
	{
		var server:Server = Thread.readMessage(true);
		var socket:Socket = Thread.readMessage(true);
		var callback:Device->Void = Thread.readMessage(true);
		var device = new Device(server, socket);
		callback(device);
	}
}
