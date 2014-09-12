package haxium.client;

import haxium.protocol.filter.Filter;
import haxium.protocol.Session;
import haxium.utils.HaxiumSocket;

class Client extends HaxiumSocket
{
	public function new()
	{
		super();
		socket.setBlocking(true);
	}

	public function get(?filters:Array<DFilter>):Session
	{
		/*
		var session = new Session(GET, filters);
		var request = Request.create(session);
		sendRequest(request);
		socket.waitForRead();
		trace("read");
		*/
		return null;
	}
}
