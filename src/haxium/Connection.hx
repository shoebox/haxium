package haxium;

#if flash
import flash.events.Event;
import flash.events.IOErrorEvent;
import flash.events.ProgressEvent;
import flash.utils.ByteArray;
#else
#end

import msignal.Signal;

class Connection extends flash.net.Socket
{
	public var host(default, null):String;
	public var whenConnected:Signal0;
	public var whenDatas:Signal1<String>;

	var baseUrl:String;

	inline static var ENCODING:String = "application/json;charset=UTF-8";

	public function new(base:String = "/wd/hub/")
	{
		this.baseUrl = base;
		whenConnected = new Signal0();
		whenDatas = new Signal1();
		super();
	}

	override public function connect(host:String ,port:Int)
	{
		this.host = host;
		addEventListener(Event.CONNECT, socketConnected);
		super.connect(host, port);
	}

	public function send(url:String, method:String)
	{
		trace("send ::: " + url + " /// " + method);
		var sendString = "POST /wd/hub/status HTTP/1.1\r\n"
			+ "Host: " + host + "\r\n"
			+ "\r\n";
		trace(sendString);
		writeMultiByte(sendString, ENCODING);
	}

	function socketConnected(_)
	{
		trace("socketConnected");
		addEventListener(ProgressEvent.SOCKET_DATA, onDatas);
		whenConnected.dispatch();
	}

	function onDatas(_)
	{
		var datas = readMultiByte(bytesAvailable, ENCODING);
		whenDatas.dispatch(datas);
	}
}