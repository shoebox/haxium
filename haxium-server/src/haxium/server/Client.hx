package haxium.server;

import haxe.crypto.Md5;
import sys.net.Socket;
import haxium.utils.HaxiumUtil;

class Client
{
	public var id(default, null):String;
	public var expiry(default, null):Date;
	public var socket(default, null):Socket;

	public function new(socket:Socket)
	{
		this.socket = socket;
		this.expiry = Date.now();
		this.id = HaxiumUtil.ID(socket.peer().host.toString());
		socket.setBlocking(false);
	}
}
