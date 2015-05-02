
import android.monkey.MonkeyDevice;
import android.monkey.MonkeyRunner;
import haxium.Device;
import haxium.protocol.By;
import haxium.protocol.Command;
import haxium.protocol.Element;
import haxium.protocol.ElementCommand;
import haxium.protocol.Protocol;
import haxium.Server;
import haxium.util.Log;
import massive.munit.client.HTTPClient;
import massive.munit.client.JUnitReportClient;
import massive.munit.client.PrintClient;
import massive.munit.client.RichPrintClient;
import massive.munit.client.SummaryReportClient;
import massive.munit.TestRunner;

class Main
{
	public static var currentDevice:Device;

	var runner:MonkeyRunner;
	var server:Server;

	public function new()
	{
		server = new Server(4242);
		server.listenForMonkey(whenMonkeyConnected);
		server.listen(whenDeviceConnected);
	}

	function whenMonkeyConnected(monkey:MonkeyDevice)
	{
		trace("whenMonkeyConnected :::: ");	
		monkey.wake();
		var device = monkey.getProperty("build.device");
		trace(device);
		var fingerprint = monkey.getProperty("build.fingerprint");
		trace(fingerprint);
		monkey.startActivity("com.massiveinteractive.storefront.companion.test.debug", 
			"MainActivity");
	}

	function whenDeviceConnected(device:Device)
	{
		currentDevice = device;
		var test = new TestMain();
	}

	static function main(){	new Main(); }
}
