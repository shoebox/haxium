package monkey;

import haxium.protocol.Protocol;
import monkey.MonkeyDevice;
import monkey.MonkeyThread;
import msignal.Signal;

class MonkeyRunner
{
	public var monkey(default, null):MonkeyThread;
	public var device(default, null):MonkeyDevice;
	public var deviceConnected(default, null):Signal1<MonkeyDevice> = new Signal1();

	public static inline var Imports = "from com.android.monkeyrunner import MonkeyRunner, MonkeyDevice";
	public static inline var WaitForConnection = "device = MonkeyRunner.waitForConnection()";
	public static inline var PrintDevice = "print device";
	public static var ERegDevice = ~/^<com.android.monkeyrunner.MonkeyDevice/i;

	public function new()
	{
		monkey = new MonkeyThread();
		imports();
	}

	public function imports()
	{
		monkey.sendMessage(Imports);
	}

	public function waitForConnection(timeout:Float = -1, ?deviceId:String)
	{
		monkey.sendMessage(WaitForConnection);
		monkey.sendMessage(PrintDevice);
		var device = monkey.waitForAnswer();
		var monkeyDevice = new MonkeyDevice(monkey);
		if (ERegDevice.match(device)) deviceConnected.dispatch(monkeyDevice);
	}

	public function alert(message:String, title:String, okTitle:String)
	{

	}

	public function choice(message:String, choices:Array<String>, title:String)
	{

	}

	public function help(?format:String)
	{

	}

	public function input(message:String, initialValue:String, title:String,
		okTitle:String, cancelTitle:String):String
	{
		return null;
	}

	public function sleep(seconds:Float)
	{

	}
}
