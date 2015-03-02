package;

import openfl.text.TextField;
import haxium.Protocol;
import openfl.display.Sprite;

import haxium.Client;

class MainTest extends Sprite{
	
	var toto:TextField;
	
	public function new () {
		
		super ();

		toto = new TextField();

		var client = new Client("192.168.1.101", 8080);
		client.connect();
		trace("connected");
		var command = Protocol.readCommand(client.socket.input);
		// switch (command)
		// {
		// 	case Command.Element(action, id):
		// 		switch (action)
		// 		{
		// 			case GetBounds(value):	
		// 				trace("GetBounds ::: " + value);
		// 				var response = Command.Element(GetBounds("osef"), "response");
		// 				haxe.Timer.delay(function()
		// 				{
		// 					Protocol.writeDynamic(client.socket.output, response);	
		// 				}, 50000);
						

		// 			default:
		// 		}
		// }
	}
}
