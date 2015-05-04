package haxium;

import haxium.protocol.command.Command;
import haxium.protocol.TouchType;
import haxium.protocol.Elements;
import neko.vm.Thread;
import sys.net.Socket;

class Device
{
	public var socket(default, null):Socket;
	public var server(default, null):Server;
	public var elements(default, null):Elements;
	public var session(default, null):Session;

	function new(server:Server, socket:Socket)
	{
		this.server = server;
		this.socket = socket;
		this.elements = new Elements(this);
		this.session = new Session(this);
	}

	public static function create(server:Server, socket:Socket, 
		whenConnected:Device->Void)
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

	public function drag(startX:Int, startY:Int, endX:Int, endY:Int, 
		duration:Float, steps:Int):Bool
	{
		var command = Command.Drag(startX, startY, endX, endY, duration, steps);
		return runCommand(command);
	}

	public function press(x:Int, y:Int):Bool
	{
		var command = Command.Press(x, y);
		return runCommand(command);
	}

	public function tap(x:Int, y:Int):Bool
	{
		var command = Command.Tap(x, y);
		return runCommand(command);
	}

	public function touch(x:Int, y:Int, type:TouchType):Bool
	{
		var command = Command.Touch(x, y, type);
		return runCommand(command);
	}

	function runCommand(command:Dynamic):Dynamic
	{
		server.writeCommand(command);
		var response = server.readCommand();
		return response;
	}
}
