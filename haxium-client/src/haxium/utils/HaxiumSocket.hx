package haxium.utils;

import haxe.io.Bytes;

import haxe.Serializer;
import haxe.Unserializer;
//import haxium.protocol.action.AbstractAction;
import msignal.Signal;

#if flash
import flash.net.Socket;
import flash.events.Event;
import flash.events.IOErrorEvent;
import flash.events.ProgressEvent;
import flash.events.SecurityErrorEvent;
import flash.utils.ByteArray;
#else
import sys.net.Socket;
import sys.net.Host;
#end

class HaxiumSocket
{
	public var opened:Signal0;
	public var socket:Socket;

	public function new()
	{
		opened = new Signal0();

		socket = new Socket();
		#if flash
			socket.addEventListener(Event.CLOSE, onSocket_closed);
			socket.addEventListener(Event.CONNECT, whenConnected);
			socket.addEventListener(IOErrorEvent.IO_ERROR, onSocket_error);
			socket.addEventListener(SecurityErrorEvent.SECURITY_ERROR, onSecurity_error);
			socket.addEventListener(ProgressEvent.SOCKET_DATA, onSocket_datas);
		#else
				
		#end
	}

	public function connect(host:String, port:Int)
	{
		#if flash
			socket.connect(host, port);
		#else
			try {
				socket.connect(new Host(host), port);
				//socket.setBlocking(false);
				whenConnected(null);
			} 
			catch (e:Dynamic)
			{
				trace("e ::: " + e);
			}
		#end	
	}
	
	public function send(datas:Bytes)
	{
		sendDatas(socket, datas);
	}

	static public function sendDatas(socket:Socket, datas:Bytes)
	{
		#if flash
			socket.writeBytes(datas.getData(), 0, datas.length);
			socket.flush();
		#else
			socket.output.writeBytes(datas, 0, datas.length);
			socket.output.flush();
		#end
	}

	#if flash
	function onSocket_closed(?e:Dynamic)
	{
		trace("closeD ::: " + e);
	}

	function onSocket_error(e:Dynamic)
	{
		trace("onSocket_error ::: " + e);
	}

	function onSecurity_error(e:Dynamic)
	{
		trace("onSecurity_error ::: " + e);
	}

	function onSocket_datas(e:Dynamic)
	{
		trace("onSocket_datas ::: " + e);
		//trace(socket.bytesAvailable);
		//trace(socket.readUTFBytes(socket.bytesAvailable));

		var len = socket.readMultiByte(socket.bytesAvailable, "");
		trace("len ::: " + len);
		//var data = socket.readUTFBytes(socket.bytesAvailable);
		//parseDatas(data);
	}

	#end

	/*
	public function sendAction(action:AbstractAction<Dynamic>)
	{
		var s = Serializer.run(action);
		var b = Bytes.ofString(s);
		send(b);
	}
	*/

	function parseDatas(raw:String)
	{
		trace("parseDatas ::: " + raw);
		var d = Unserializer.run(raw);
		trace(d);
	}

	function whenConnected(_)
	{
		opened.dispatch();
	}
	
}
