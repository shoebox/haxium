package haxium.protocol;

import haxium.protocol.Command;
import haxium.protocol.ElementCommand;
import haxium.protocol.ElementCommand.ElementBounds;
import haxium.Server;
import monkey.MonkeyDevice;

class Element
{
	public var bounds(get, null):ElementBounds;
	public var device(default, null):MonkeyDevice;
	public var server(default, null):Server;
	public var id(default, null):String;

	public function new(id:String, server:Server, device:MonkeyDevice)
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

	function get_bounds():ElementBounds
	{
		var result:ElementBounds = null;
		var command:Command = runElementCommand(ElementCommand.GetBounds());
		switch (command)
		{
			case Element(action, id):
				switch (action)
				{
					case ElementCommand.GetBounds(bounds):
						result = bounds;

					default:
				}

			default:
		}
		return result;
	}

	function runElementCommand(action:ElementCommand):Command
	{
		var command = Command.Element(action, id);
		server.writeCommand(command);
		var result = server.readCommand();
		return result;
	}
}
