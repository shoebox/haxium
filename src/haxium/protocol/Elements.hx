package haxium.protocol;

import haxium.protocol.command.Command;
import haxium.protocol.element.Element;
import haxium.protocol.command.ElementFilter;
import haxium.Server;
import haxium.Device;

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

		// var element:Element;
		var result:Array<Element> = [];

		// var command = device.server.readCommand();
		// switch (command)
		// {
		// 	case ElementCommandResult.GetChild(list):
		// 		for (id in list)
		// 		{
		// 			element = new Element(id, device);
		// 			result.push(element);
		// 		}

		// 	default:
		// }
		return result;
	}
}
