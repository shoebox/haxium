package haxium.server;

import haxe.Unserializer;
import haxium.protocol.ActionType;
import haxium.server.RemoteClient;
import haxium.server.Sessions;
import haxium.protocol.action.SessionAction;

import sys.net.Socket;
import neko.net.ThreadServer;
import haxe.io.Bytes;
import haxe.Serializer;

typedef Message = {
  var str : String;
};

class HaxiumServer extends ThreadServer<RemoteClient, Message>
{
	public var sessions:Sessions;

	public function new()
	{
		super();
		sessions = new Sessions();
	}

	override function clientConnected(s : Socket):RemoteClient
	{
		var client = new RemoteClient();
		return client;
	}

	override function readClientMessage(c:RemoteClient, buf:Bytes, pos:Int, len:Int):Dynamic
	{
		var o = Unserializer.run(buf.toString());
		trace("readClientMessage");

		if (Std.is(o, SessionAction))
		{
			trace("SessionAction");
		}

		return null;
	}

	override function clientDisconnected(c:RemoteClient)
	{
		
	}
}
