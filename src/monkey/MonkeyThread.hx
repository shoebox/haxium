package monkey;

import haxe.io.Bytes;
import neko.vm.Thread;
import sys.io.Process;
import msignal.Signal;

typedef PrintStream =
{
	@:optional var out:String->Void;
	@:optional var err:String->Void;
}

class MonkeyThread
{
	public var process(default, null):Process;

	public static inline var Path = "/Users/johann.martinache/Desktop/android/sdk/tools/./monkeyrunner";

	public function new()
	{
		process = new Process(Path, []);
		var thread = Thread.create(function()
		{
			var p = Thread.readMessage(true);
			while (true)
			{
				var error = process.stderr.readLine();
				if (error != "") Sys.println('\033[31m ' + error);
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
			Sys.println("\033[33m" + result);
			if (result != null) break;
		}
		return result;
	}

	public function sendMessage(message:String)
	{
		Sys.println("\033[32m" + message);
		process.stdin.writeString(message + "\n");	
		var result = waitForAnswer();
		if (result != '>>> $message') throw "Error while sending message";
	}
}
