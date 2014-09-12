package haxium.server;

import haxe.io.Bytes;
import haxe.io.BytesInput;

import haxe.Unserializer;
import haxium.protocol.ClientSession;
import haxium.protocol.Session;
import haxium.server.Protocol;
import haxium.server.Sessions;
import haxium.protocol.RemoteProtocol;

import neko.net.ServerLoop;
import neko.net.ThreadServer;

import sys.net.Host;

import sys.net.Socket;

typedef Client =  {
	var socket:Socket;
	var contentLength:Int;
}

class Server extends ServerLoop<Client>
{
	public var sessions:Sessions;

	public function new()
	{
		super(function(socket) {
			return {
				contentLength:-1, socket:socket
			};
		});

		sessions = new Sessions();
	
		Sys.println("\n");
		Sys.println("db   db  .d8b.  db    db d888888b db    db .88b  d88. ");
		Sys.println("88   88 d8' `8b `8b  d8'   `88'   88    88 88'YbdP`88 ");
		Sys.println("88ooo88 88ooo88  `8bd8'     88    88    88 88  88  88 ");
		Sys.println("88~~~88 88~~~88  .dPYb.     88    88    88 88  88  88 ");
		Sys.println("88   88 88   88 .8P  Y8.   .88.   88b  d88 88  88  88 ");
		Sys.println("YP   YP YP   YP YP    YP Y888888P ~Y8888P' YP  YP  YP ");
		Sys.println("---------------------------------------- [Server] --- ");
		Sys.println("\n");
	}

	public function connect(host:String, port:Int)
	{
		run(new Host(host), port);
	}

	override function processClientData(client:Client, buf:Bytes, 
		pos:Int, len:Int):Int
	{
		var request = RemoteProtocol.readObject(client.socket.input);
		trace("request === " + request.action);
		/*
		var session:ClientSession;
		switch (request.action)
		{
			case RemoteProtocol.CREATE:
				session = sessions.create(request.datas.specs, client.socket);
				RemoteProtocol.created(client.socket, session);

			case RemoteProtocol.HOOK:
				var hook = sessions.hook(request.datas.body);
				RemoteProtocol.hook(client.socket, hook);
		}
		*/
		return len;
	}
}
