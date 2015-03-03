package;

import haxium.plugin.OpenFlHandler.OpenFlHander;
import openfl.text.TextField;
import haxium.protocol.Protocol;
import openfl.display.Sprite;
import openfl.events.MouseEvent;

import haxium.Client;

class MainTest extends Sprite{
	
	var button:Sprite;
	
	public function new () {
		
		super ();
		trace("this ::: " + this);

		button = new Sprite();
		button.width = button.height = 100;
		button.name = "toto";
		button.graphics.beginFill(0xff6600);
		button.graphics.drawRect(0, 0, 100, 100);
		button.mouseEnabled = button.useHandCursor = true;
		button.addEventListener(MouseEvent.CLICK, function(_)
		{
			trace("click");
			});
		button.graphics.endFill();
		addChild(button);

		haxe.Timer.delay(
			function()
			{
				trace("client");
				var client = new Client("192.168.1.64", 8080);
				client.addHandler(new OpenFlHander());
				client.connect();
			}, 500
		);
	}
}
