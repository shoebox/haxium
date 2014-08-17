package haxium.server;

import haxe.crypto.Md5;
import haxe.io.Bytes;

import sys.net.Socket;

class RemoteClient
{
	public var id:String;
	public var expiry:Date;

	public function new(socket:Socket)
	{
		expiry = Date.now();
		id = Md5.encode(expiry.toString());
		socket.output.write(Bytes.ofString(id));
		socket.output.flush();
	}
}
