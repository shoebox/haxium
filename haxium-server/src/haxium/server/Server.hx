package haxium.server;

import haxe.io.Bytes;
import haxe.io.BytesInput;
import haxe.Unserializer;

import haxium.protocol.ClientSession;
import haxium.protocol.RemoteProtocol;
import haxium.protocol.Session;
import haxium.server.Client;
import haxium.server.Protocol;
import haxium.server.Sessions;
import haxium.utils.HaxiumUtil;

import neko.net.ServerLoop;
import neko.net.ThreadServer;

import sys.net.Host;
import sys.net.Socket;

class Server extends ThreadServer<Client, RemoteRequest<Dynamic>>
{
	public var sessions:Sessions;

	public function new()
	{
		super();

		sessions = new Sessions();
		HaxiumUtil.println('');
		HaxiumUtil.println('##  ##  ####  ##  ## #### ##  ## ### ###');
		HaxiumUtil.println('##  ## ##  ##  ####   ##  ##  ## #######');
		HaxiumUtil.println('###### ######   ##    ##  ##  ## ## # ##');
		HaxiumUtil.println('##  ## ##  ##  ####   ##  ##  ## ## # ##');
		HaxiumUtil.println('##  ## ##  ## ##  ## ####  ####  ##   ##');
		HaxiumUtil.println('');
		HaxiumUtil.print('----------------------------- ');
		HaxiumUtil.print('Server', HaxiumUtil.YELLOW);
		HaxiumUtil.print(' ---');
		HaxiumUtil.println('');
	}

	override function clientConnected(socket:Socket) : Client
	{
		var client = new Client(socket);
		trace("clientConnected ::: " + client.id);
		return client;
	}

	override function clientDisconnected( c : Client )
  	{
    	Sys.println("client " + Std.string(c.id) + " disconnected");
	}

	function createClient(socket:Socket):Client
	{
		var client = new Client(socket);
		return client;
	}

	public function connect(host:String, port:Int)
	{
		run(host, port);
	}

	override function readClientMessage(client:Client, bytes:Bytes, 
		position:Int, length:Int)
	{
		var request = RemoteProtocol.getFromBytes(bytes);
		if (request == null)
			return null;

		return {msg: request, bytes: request.length};
	}

	override function clientMessage(client:Client, 
		request:RemoteRequest<Dynamic>)
	{
		Sys.println(client.id + " sent: " + request.length);
		var session:ClientSession;
		switch (request.action)
		{
			case RemoteProtocol.CREATE:
				HaxiumUtil.println('<< Create session for ${client.id}');
				session = sessions.create(request.datas.specs, client.socket);

				HaxiumUtil.println('>> Session created session ${session}', 
					HaxiumUtil.YELLOW);
				
				RemoteProtocol.created(client.socket, session);

			default:
		}
	}
}
