package monkey;

import monkey.MonkeyRunner;
import haxium.Server;
import monkey.MonkeyThread;

class MonkeyDevice
{
	public var thread(default, null):MonkeyThread;
	public var activityName(default, default):String = "MainActivity";
	public var appPackage(default, default):String = "org.shoebox.haxium";

	public var server:Server;

	public function new(thread:MonkeyThread)
	{
		this.thread = thread;
		run();
	}

	public function run()
	{
		server = new Server(8080);
		thread.sendMessage('device.startActivity("$appPackage/$appPackage.$activityName")');
	}
}
