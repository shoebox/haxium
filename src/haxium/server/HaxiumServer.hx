package haxium.server;

import haxe.io.Bytes;
import haxe.Serializer;
import haxe.Unserializer;

import haxium.protocol.action.SessionAction;
import haxium.protocol.ActionType;
import haxium.server.RemoteClient;
import haxium.server.Sessions;

import neko.net.ThreadServer;

import sys.net.Socket;

class HaxiumServer extends ThreadServer<RemoteClient, Dynamic>
{
	public var sessions:Sessions;

	public function new()
	{
		super();
		sessions = new Sessions();
	}

	override function clientConnected(s : Socket):RemoteClient
	{
		return new RemoteClient(s);
	}

	override function readClientMessage(client:RemoteClient, buf:Bytes, pos:Int, len:Int):Dynamic
	{
		var o = Unserializer.run(buf.toString());
		if (Std.is(o, SessionAction))
			return sessions.execute(cast o, client);
		
		return null;
	}

	override function clientDisconnected(c:RemoteClient)
	{
		
	}
}
