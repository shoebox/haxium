package haxium.server;

import haxe.io.Bytes;
import haxe.io.BytesInput;

import haxium.protocol.session.SessionProtocol;
import haxium.server.Client;
import haxium.server.Protocol;
import haxium.server.Sessions;

import neko.net.ThreadServer;

import sys.net.Socket;

class Server extends ThreadServer<Client, Dynamic>
{
	var sessions:Sessions;

	public function new()
	{
		super();
		sessions = new Sessions();
	}

	override function clientConnected(s : Socket):Client
	{
		return new Client(s);
	}

	override function readClientMessage(client:Client, buf:Bytes, 
		pos:Int, len:Int)
	{
		var bytes = buf.sub(pos, len);
		var input = new BytesInput(bytes);
		var type = input.readInt32();
		input.position = 0;

		var sessionAction:SessionAction;
		switch (type)
		{
			case SessionProtocol.CREATE 
				| SessionProtocol.JOIN
				| SessionProtocol.LIST 
				| SessionProtocol.GET 
				| SessionProtocol.CLOSE:
				sessionAction = SessionAction.deserialize(bytes);
				sessions.execute(client, sessionAction);
		}

		return null;
	}

	override function clientDisconnected(c:Client)
	{

	}
}
