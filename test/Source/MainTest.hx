package;

import haxium.plugin.OpenFlHandler.OpenFlHander;
import openfl.text.TextField;
import haxium.protocol.Protocol;
import openfl.display.Sprite;
import openfl.events.MouseEvent;

import haxium.Client;
import sys.net.Host;

class MainTest extends Sprite{
	
	var button:Sprite;
	var button2:Sprite;
	
	public function new () {
		
		super ();
		trace("this ::: " + this);

		button = new Sprite();
		button.name = "sprite1";
		button.width = button.height = 100;
		button.graphics.beginFill(0xff6600);
		button.graphics.drawRect(0, 0, 100, 100);
		button.mouseEnabled = button.useHandCursor = true;
		button.addEventListener(MouseEvent.CLICK, function(_)
		{
			trace("click");
			});
		button.graphics.endFill();
		addChild(button);

		button2 = new Sprite();
		button2.name = "sprite2";
		button2.x = 200;
		button2.width = button2.height = 100;
		button2.graphics.beginFill(0xff6600);
		button2.graphics.drawRect(0, 0, 100, 100);
		button2.mouseEnabled = button2.useHandCursor = true;
		button2.addEventListener(MouseEvent.CLICK, function(_)
		{
			trace("click");
			});
		button2.graphics.endFill();
		addChild(button2);

		haxe.Timer.delay(
			function()
			{
				trace("client");

				var host:String = Host.localhost();
				#if mobile
				host = "192.168.1.64";
				#end

				var client = new Client(host, 8080);
				client.addHandler(new OpenFlHander());
				client.connect();
			}, 500
		);
	}
}
