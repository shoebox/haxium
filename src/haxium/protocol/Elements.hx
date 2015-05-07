package haxium.protocol;

import haxium.protocol.command.Command;
import haxium.protocol.command.ResponseCommand;
import haxium.protocol.element.Element;
import haxium.protocol.command.ElementFilter;
import haxium.Server;
import haxium.Device;
import haxium.util.Log;

class Elements
{
	public var device(default, null):Device;
	
	public function new(device:Device)
	{
		this.device = device;
	}

	public function get(?filter:ElementFilter):Array<Element>
	{
		var command = Command.GetChild(filter);
		device.server.writeCommand(command);
		var response = device.server.readCommand();

		var element:Element;
		var result:Array<Element> = [];
		switch (response)
		{
			case ResponseCommand.GetChilds(list):
				for (id in list)
				{
					element = new Element(id, device);
					result.push(element);	
				}

			default:
				//TODO(Johann) : Should fire a error
		}

		return result;
	}
}
