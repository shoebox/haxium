package haxium;

import haxium.protocol.command.Command;
import haxium.protocol.Elements;
import haxium.Device;

class Session
{
	public var device(default, null):Device;
	// public var url(get, null):String;

	public function new(device:Device)
	{
		this.device = device;
	}

	// function get_url():String
	// {
	// 	// trace("get_url");
	// 	// // var deviceCommand = 
	// 	// //Click(stageX, stageY);
	// 	// var command = Command.SessionAction(SessionCommand.GetUrl);
	// 	// device.server.writeCommand(command);

	// 	// // var response = server.readCommand();
	// 	// return "";
	// }
}
