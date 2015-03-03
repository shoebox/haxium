import haxium.protocol.Element;
import haxium.protocol.Protocol;
import haxium.protocol.Command;
import haxium.protocol.ElementCommand;
import haxium.util.Log;
import monkey.MonkeyDevice;
import monkey.MonkeyRunner;

class Main
{
	var runner:MonkeyRunner;

	public function new()
	{
		runner = new MonkeyRunner();
		runner.deviceConnected = deviceConnected;
		runner.waitForConnection();
	}

	function deviceConnected(device:MonkeyDevice)
	{	
		device.startActivity();
		var element:Element = device.getElement("toto");
		element.click();
		
		// device.server.writeCommand(Command.Element(ElementCommand.GetBounds(null), "toto"));
		// trace(device.server.readCommand());
		while(true){}
	}


	static function main(){	new Main(); }
}
