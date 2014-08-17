package haxium.utils;

import haxe.io.Bytes;

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

	var socket:Socket;

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
		#if flash
			socket.writeBytes(datas.getData(), 0, datas.length);
			socket.flush();
		#else
			socket.output.writeBytes(data, 0, datas.length);
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
		trace("onSocket_datas ::: " + socket.readByte());
	}

	#end

	function whenConnected(_)
	{
		opened.dispatch();
	}
	
}