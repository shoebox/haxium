import haxium.protocol.Element;
import haxium.protocol.Protocol;
import haxium.protocol.Command;
import haxium.protocol.ElementCommand;
import haxium.Server;
import haxium.util.Log;
import monkey.MonkeyDevice;
import monkey.MonkeyRunner;

class Main
{
	var device:MonkeyDevice;
	var runner:MonkeyRunner;
	var server:Server;

	public function new()
	{
		#if android
		runner = new MonkeyRunner();
		runner.deviceConnected = deviceConnected;
		runner.waitForConnection();
		#else
		device = new MonkeyDevice(null);
		device.listen();
		#end

		deviceConnected(device);
		while(true){}
	}

	function deviceConnected(device:MonkeyDevice)
	{	
		#if android
		device.startActivity();
		#end

		trace("deviceConnected");

		var sprites = device.elements.getByType("openfl._v2.display.Sprite");
		var element:Element = sprites[0];
		element.click();

		var element:Element = sprites[1];
		element.click();

		// trace(device.elements.getByType("openfl.display.MovieClip"));
		// trace(device.elements.getByType("openfl.display.Sprite"));

		// var element:Element = device.getElement("toto");
		// element.click();
		
		// device.server.writeCommand(Command.Element(ElementCommand.GetBounds(null), "toto"));
		// trace(device.server.readCommand());
		while(true){}
	}

	static function main(){	new Main(); }
}
