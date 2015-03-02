import haxium.protocol.Protocol;
import haxium.protocol.Command;
import haxium.protocol.ElementCommand;
import monkey.MonkeyDevice;
import monkey.MonkeyRunner;

class Main
{
	var runner:MonkeyRunner;

	public function new()
	{
		runner = new MonkeyRunner();
		runner.deviceConnected.add(deviceConnected);
		runner.waitForConnection();
	}

	function deviceConnected(device:MonkeyDevice)
	{
		trace("deviceConnected ::: ");	
		// device.server.writeCommand(Command.Element(ElementCommand.GetBounds(null), "toto"));
		// trace(device.server.readCommand());
		while(true){}
	}


	static function main(){	new Main(); }
}
