package android.monkey;

import haxium.protocol.Protocol;
import android.monkey.MonkeyDevice;
import android.monkey.MonkeyThread;
import msignal.Signal;

#if neko
import neko.vm.Thread;
#else
import cpp.vm.Thread;
#end

class MonkeyRunner
{
	public var device(default, default):MonkeyDevice;
	public var listener(default, null):MonkeyDevice->Void;
	public var thread(default, null):MonkeyThread;

	static inline var Imports = "from com.android.monkeyrunner import MonkeyRunner, MonkeyDevice";
	static inline var WaitForConnection = "device = MonkeyRunner.waitForConnection()";
	static inline var PrintDevice = "print device";

	static var ERegDevice = ~/^<com.android.monkeyrunner.MonkeyDevice/i;

	function new(listener:MonkeyDevice->Void)
	{
		this.thread = new MonkeyThread();
		this.listener = listener;
		imports();
	}

	public function imports()
	{
		thread.sendMessage(Imports);
	}

	public function waitForConnection(timeout:Float = -1, ?deviceId:String)
	{
		thread.sendMessage(WaitForConnection);
		thread.sendMessage(PrintDevice);
		var answer = thread.waitForAnswer();
		if (ERegDevice.match(answer))
		{
			var result = new MonkeyDevice(thread);
			if (listener != null) listener(result);
			device = result;
		} 
	}

	public static function create(listener:MonkeyDevice->Void, 
		timeout:Float = -1, ?deviceId:String)
	{	
		var thread = Thread.create(createThread);
		thread.sendMessage(listener);
		thread.sendMessage(timeout);
		thread.sendMessage(deviceId);
	}

	static function createThread()
	{
		var listener:MonkeyDevice->Void = Thread.readMessage(true);
		var timeout:Int = Thread.readMessage(true);
		var deviceId:String = Thread.readMessage(true);
		var runner = new MonkeyRunner(listener);
		runner.waitForConnection(timeout, deviceId);
	}
}

/*
	public var monkey(default, null):MonkeyThread;
	public var device(default, default):MonkeyDevice;
	public var deviceConnected(default, default):MonkeyDevice->Void;

	static inline var Imports = "from com.android.monkeyrunner import MonkeyRunner, MonkeyDevice";
	static inline var WaitForConnection = "device = MonkeyRunner.waitForConnection()";
	static inline var PrintDevice = "print device";

	static var ERegDevice = ~/^<com.android.monkeyrunner.MonkeyDevice/i;

	public function new()
	{
		trace("constructor");
		monkey = new MonkeyThread();
		imports();
	}

	public static function create(timeout:Float = -1, ?deviceId:String)
	{
		var runner = new MonkeyRunner();

	}

	public function imports()
	{
		monkey.sendMessage(Imports);
	}

	public function waitForConnection(timeout:Float = -1, ?deviceId:String)
	{
		monkey.sendMessage(WaitForConnection);
		monkey.sendMessage(PrintDevice);
		var answer = monkey.waitForAnswer();
		if (ERegDevice.match(answer))
		{
			var result = new MonkeyDevice(monkey);
			// if (deviceConnected != null) deviceConnected(result);
			device = result;
		} 
	}

	function listenForConnection()
	{

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
*/
