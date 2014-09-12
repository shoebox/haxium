package haxium.protocol;

import haxe.io.Bytes;
import haxe.io.Error;

import haxium.protocol.ClientSession;
import haxium.protocol.Session;

class Hook
{
	public var sessions(default, null):Array<ClientSession>;

	public function new(sessions:Array<ClientSession>)
	{
		this.sessions = sessions;
		for (session in sessions)
		{
			if (session.hooked)
				throw "Cannot hook an already hooked session";

			session.hooked = true;
		}
	}

	public function send(bytes:Bytes)
	{
		
	}
}
