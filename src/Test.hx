package;

import haxium.client.HaxiumDriver;

//import haxium.Haxium;

class Test
{
	static var driver:HaxiumDriver;

	static public function main()
	{
		trace('constructor');

		driver = new HaxiumDriver();
		driver.connected.add(whenConnected);
		driver.connect("localhost", 1234);
	}

	static function whenConnected()
	{
		trace("whenConnected");
		driver.createSession();
	}

	/*
	static function ioError(e:IOErrorEvent)
	{
		trace("error /// " + e);
	}

	static function connectionClose(e:Event)
	{
		trace("close /// " + e);
	}

	static function onDatas(datas:ProgressEvent)
	{
		trace("onDatas ///" + datas.toString());
		trace(socket.readMultiByte(socket.bytesAvailable, "application/json;charset=UTF-8"));
	}

	static function connected(_)p
	{
		trace("connected");


		var sendString = "POST /wd/hub/session HTTP/1.1\r\n"
			+ "Host: localhost\r\n"
			+ "\r\n";
			
		socket.writeMultiByte(sendString, "application/json;charset=UTF-8");
		*/

		//var haxium:Haxium = new Haxium();
		//haxium.open("localhost", 8484);
		
	

}
