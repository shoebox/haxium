package haxium.protocol;

import haxium.protocol.Command;
import haxium.protocol.ElementCommand;
import haxium.protocol.ElementCommand.ElementBounds;
import haxium.Server;
import haxium.Device;

class Element
{
	public var bounds(get, null):ElementBounds;
	public var device(default, null):Device;
	public var id(default, null):String;
	public var server(default, null):Server;

	public function new(id:String, server:Server, device:Device)
	{
		this.device = device;
		this.id = id;
		this.server = server;
	}

	public function click()
	{
		var remoteBounds = bounds;
		var x = Std.int(remoteBounds.position.x + remoteBounds.width / 2);
		var y = Std.int(remoteBounds.position.y + remoteBounds.height / 2);

		device.touch(x, y);
	}

	public function setProperty(property:String, value:Dynamic)
	{
		var result = runElementAction(SetProperty(property, value));	
	}

	public function getProperty(property:String):Dynamic
	{
		var result = runElementAction(GetProperty(property));	
		return result;
	}

	function get_bounds():ElementBounds
	{
		var result = runElementAction(GetBounds);
		var bounds:ElementBounds = cast result;
		return bounds;
	}

	function runElementAction(action:ElementCommand):Dynamic
	{	
		var command:Command = Command.ElementCommand(id, action);
		server.writeCommand(command);
		var result = server.readCommand();
		return result;
	}
}
