package haxium.server;

import haxe.io.Bytes;
import haxe.Serializer;
import haxe.Unserializer;

import haxium.protocol.action.AbstractAction;
import haxium.protocol.action.SessionAction;
import haxium.protocol.ActionType;
import haxium.server.RemoteClient;
import haxium.server.Sessions;

import neko.net.ThreadServer;

import sys.net.Socket;

typedef Client = {
  var id : Int;
}

class HaxiumServer extends ThreadServer<RemoteClient, SessionAction>
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

	override function readClientMessage(client:RemoteClient, buf:Bytes, 
		pos:Int, len:Int)
	{
		var cpos = pos;
		var msg = buf.getString(pos,  len);
		var o = Unserializer.run(msg);
		
		var action:SessionAction = null;
		if (Std.is(o, SessionAction))
		{
			action = cast o;
			sessions.execute(action, client);
		}

		return {msg:action, bytes: len};
	}

	override function clientDisconnected(c:RemoteClient)
	{
		
	}
}
