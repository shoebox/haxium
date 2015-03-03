package monkey;

import haxium.protocol.Element;
import monkey.MonkeyRunner;
import haxium.Server;
import monkey.MonkeyThread;

class MonkeyDevice
{
	public var activityName(default, default):String = "MainActivity";
	public var appPackage(default, default):String = "org.shoebox.haxium";
	public var server(default, null):Server;
	public var thread(default, null):MonkeyThread;

	public function new(thread:MonkeyThread)
	{
		this.thread = thread;
	}

	public function startActivity()
	{
		thread.sendMessage('device.startActivity("$appPackage/$appPackage.$activityName")');
		server = new Server(8080);
	}

	public function getElement(id:String):Element
	{
		var result = new Element(id, server, this);
		return result;
	}

	public function touch(x:Int, y:Int, ?type:String)
	{
		type = type == null ? TouchType.Down : type;
		thread.sendMessage('device.touch($x, $y, $type)');
	}
}

class TouchType
{
	public static inline var Down = "'DOWN'";
	public static inline var DownAndUp = "'DOWN_AND_UP'";
	public static inline var Up = "'UP'";
}
