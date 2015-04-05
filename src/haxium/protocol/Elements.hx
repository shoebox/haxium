package haxium.protocol;

import haxium.protocol.Command;
import haxium.protocol.Element;
import haxium.protocol.ElementCommand;
import haxium.Server;
import monkey.MonkeyDevice;

class Elements
{
	public var device(default, null):MonkeyDevice;
	public var server(default, null):Server;

	public function new(server:Server, device:MonkeyDevice)
	{
		this.server = server;
		this.device = device;
	}

	public function get():Dynamic
	{
		var command = Command.Elements();
		server.writeCommand(command);
		return null;
	}

	public function getByType(type:String):Dynamic
	{
		var command = Command.ElementsByType(type);
		server.writeCommand(command);
		var result = server.readCommand();
		var elements = [];
		var element:Element;
		switch (result)
		{
			case Command.Elements(list):
				for (entry in list)
				{
					element = new Element(entry, server, device);
					elements.push(element);
				}
			default:
		}
		return elements;
	}
}
