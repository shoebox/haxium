package monkey;

import haxium.protocol.By;
import haxium.protocol.Command;
import haxium.protocol.DeviceCommand;
import haxium.protocol.Element;
import haxium.protocol.Elements;
import monkey.MonkeyRunner;
import haxium.Server;
import monkey.MonkeyThread;

import neko.vm.Thread;
import sys.net.Socket;

class MonkeyDevice
{
/*
	public var socket(default, null):Socket;
	public var elements(default, null):Elements;
	public var server(default, null):Server;

	public function new(server:Server, socket:Socket)
	{
		// this.server = server;
		// this.socket = socket;
		// this.elements = new Elements(server, this);
		// runTests();
	}

	public function runTests()
	{
		Sys.sleep(5);

		var filter = By.ElementType("mui.input.TextInput");
		var inputs = elements.get(filter);
		var element:Element = inputs[0];
		trace(element.id);
		trace(element.bounds);
		element.setProperty("data", "hello johann");

		filter = By.ElementType("store.companion.view.component.LabelledButton");
		inputs = elements.get(filter);
		element = inputs[0];
		element.click();
	}

	public function touch(stageX:Int, stageY:Int)
	{
		var deviceCommand = DeviceCommand.Click(stageX, stageY);
		var command = Command.Device(deviceCommand);
		server.writeCommand(command);
	}

	public static function create(server:Server, socket:Socket)
	{
		var thread = Thread.create(build);
		thread.sendMessage(server);
		thread.sendMessage(socket);
	}

	static function build()
	{
		var server:Server = Thread.readMessage(true);
		var socket:Socket = Thread.readMessage(true);
		var device = new MonkeyDevice(server, socket);
	}
	*/
}

