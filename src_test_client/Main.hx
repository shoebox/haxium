import haxium.protocol.Element;
import haxium.protocol.Protocol;
import haxium.protocol.Command;
import haxium.protocol.ElementCommand;
import haxium.Server;
import haxium.Device;
import haxium.util.Log;
import monkey.MonkeyDevice;
import monkey.MonkeyRunner;
import haxium.protocol.By;

import massive.munit.client.PrintClient;
import massive.munit.client.RichPrintClient;
import massive.munit.client.HTTPClient;
import massive.munit.client.JUnitReportClient;
import massive.munit.client.SummaryReportClient;
import massive.munit.TestRunner;

class Main
{
	public static var currentDevice:Device;

	var runner:MonkeyRunner;
	var server:Server;

	public function new()
	{
		server = new Server(8080);
		server.listen(whenDeviceConnected);
	}

	function whenDeviceConnected(device:Device)
	{
		Sys.sleep(15);
		currentDevice = device;
		var test = new TestMain();
	}

	static function main(){	new Main(); }
}
