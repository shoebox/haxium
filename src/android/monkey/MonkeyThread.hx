package android.monkey;

import haxe.io.Bytes;
#if neko
import neko.vm.Thread;
#elseif cpp
import cpp.vm.Thread;
#end
import sys.io.Process;
import msignal.Signal;
import haxium.util.Log;

typedef PrintStream =
{
	@:optional var out:String->Void;
	@:optional var err:String->Void;
}

class MonkeyThread
{
	public var process(default, null):Process;

	public static inline var Path = "/Users/johann.martinache/Desktop/android/sdk/tools/./monkeyrunner";

	static inline var MonkeyTag = '[MonkeyRunner] ';

	public function new()
	{
		process = new Process(Path, []);
		var thread = Thread.create(function()
		{
			var p = Thread.readMessage(true);
			while (true)
			{
				var error = process.stderr.readLine();
				if (error != "") Log.trace('$MonkeyTag' + error, Red);
			}
		});
		thread.sendMessage(process);
	}

	public function waitForAnswer():String
	{
		var result:String = null;
		while (true)
		{
			result = process.stdout.readLine();
			Log.trace('$MonkeyTag' + result, Blue);
			if (result != null) break;
		}
		return result;
	}

	public function sendMessage(message:String)
	{
		Log.trace('$MonkeyTag' + message, Blue);
		process.stdin.writeString(message + "\n");	
		var result = waitForAnswer();
		if (result != '>>> $message') throw "Error while sending message";
	}
}
