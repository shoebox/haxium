package android.monkey;

import android.monkey.MonkeyRunner;
import android.monkey.MonkeyThread;
import haxium.Server;

class MonkeyDevice
{
	public var thread(default, null):MonkeyThread;
	public var server(default, default):Server;

	public function new(thread:MonkeyThread)
	{
		this.thread = thread;
	}

	public function getProperty(key:String):String
	{
		thread.sendMessage('device.getProperty("$key")');
		var answer = thread.waitForAnswer();
		return answer;
	}

	public function getSystemProperty(key:String):String
	{
		thread.sendMessage('device.getSystemProperty("$key")');
		var answer = thread.waitForAnswer();
		return answer;
	}

	public function installPackage(path:String)
	{

	}

	public function removePackage(appPackage:String)
	{

	}

	public function startActivity(appPackage:String, activityName:String)
	{
		thread.sendMessage('device.startActivity("$appPackage/$appPackage.$activityName")');
	}

	public function touch(x:Int, y:Int, ?touchType:TouchType)
	{
		touchType = touchType == null ? TouchType.DownAndUp : touchType;
		var typeString = switch (touchType)
		{
			case Down : "'DOWN'";
			case DownAndUp : "'DOWN_AND_UP'";
			case Up : "'UP'";
		}
		thread.sendMessage('device.touch($x, $y, $typeString)');
	}

	public function wake()
	{
		thread.sendMessage("device.wake()");
	}
}

enum TouchType
{
	Down;
	DownAndUp;
	Up;
}
