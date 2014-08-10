package;

import haxium.Haxium;

class Test
{
	static public function main()
	{
		trace('constructor');

		/*
		socket = new Socket();
		socket.addEventListener(Event.CONNECT, connected);
		socket.addEventListener(IOErrorEvent.IO_ERROR, ioError);
		socket.addEventListener(Event.CLOSE, connectionClose);
		socket.addEventListener(flash.events.ProgressEvent.SOCKET_DATA, onDatas);
		socket.connect("localhost", 8484);
	}

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

		var haxium:Haxium = new Haxium();
		haxium.connect("localhost", 8484);
		
	}

}
