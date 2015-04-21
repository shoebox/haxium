package haxium.protocol;

import haxium.protocol.By;
import haxium.protocol.Command;
import haxium.protocol.Element;
import haxium.protocol.ElementCommand;
import haxium.Server;
import haxium.Device;

class Elements
{
	public var device(default, null):Device;
	public var server(default, null):Server;

	public function new(server:Server, device:Device)
	{
		this.server = server;
		this.device = device;
	}

	public function get(?filter:By):Array<Element>
	{
		var result:Array<Element> = [];
		var command = Command.Elements(filter);
		server.writeCommand(command);
		var commandResult = server.readCommand();
		
		var element:Element;
		var result:Array<Element> = [];
		switch (commandResult)
		{
			case ElementsResult(list):
				for (id in list)
				{
					element = new Element(id, server, device);
					result.push(element);
				}

			default : 
		}

		return result;
	}
}
