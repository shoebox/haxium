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

class Server extends ServerLoop<Client>
{
	public var sessions:Sessions;

	public function new()
	{
		super(createClient);

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

	function createClient(socket:Socket):Client
	{
		var client = new Client(socket);
		return client;
	}

	public function connect(host:String, port:Int)
	{
		run(new Host(host), port);
	}

	override function processClientData(client:Client, bytes:Bytes, 
		position:Int, length:Int):Int
	{
		var request = RemoteProtocol.getFromBytes(bytes);
		if (request == null)
			return 0;

		var session:ClientSession;
		switch (request.action)
		{
			case RemoteProtocol.CREATE:
				HaxiumUtil.println('<< Create session for ${client.id}');
				session = sessions.create(request.datas.specs, client.socket);

				HaxiumUtil.println('>> Session created session ${session.id}', 
					HaxiumUtil.YELLOW);
				
				RemoteProtocol.created(client.socket, session);

			default:
		}

		return request.length;
	}
}
