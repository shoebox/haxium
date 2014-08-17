package haxium.server;

import haxe.crypto.Md5;
import haxe.io.Bytes;

import haxium.protocol.action.SessionAction;
import haxium.server.RemoteClient;

class Sessions
{
	var list:Session;

	public function new()
	{

	}

	public function execute(action:SessionAction, client:RemoteClient)
	{
		var session:Session;

		switch (action.type)
		{
			case CREATE:
				session = new Session();

			default:
		}

		return null;
	}
}

class Session
{
	public var id(default, null):String;
	public var expirationDate(default, null):Date;

	public function new()
	{
		var date = Date.now();
		
		this.id = Md5.encode(date.toString());
		this.expirationDate = Date.fromTime(date.getTime() + 1800000);

		trace("create session ::: " + id);
	}
}