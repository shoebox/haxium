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
	
	public function new(device:Device)
	{
		this.device = device;
	}

	public function get(?filter:By):Array<Element>
	{
		var command = Command.Elements(filter);
		device.server.writeCommand(command);
		var commandResult = device.server.readCommand();
		
		var element:Element;
		var result:Array<Element> = [];
		switch (commandResult)
		{
			case ElementsResult(list):
				for (id in list)
				{
					element = new Element(id, device.server, device);
					result.push(element);
				}

			default : 
		}

		return result;
	}
}
