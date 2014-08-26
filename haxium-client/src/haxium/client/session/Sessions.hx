package haxium.client.session;

import haxe.io.Bytes;
import haxe.io.BytesInput;
import haxe.io.BytesOutput;
import haxe.io.Output;

import haxium.client.session.Session;
import haxium.protocol.session.SessionProtocol;
import haxium.protocol.filter.Filter;
import haxium.utils.HaxiumSocket;

class Sessions extends HaxiumSocket
{
	public function new()
	{
		super();
	}

	public function create(?filters:Array<Filter<Dynamic>>):Session
	{
		var action = new SessionAction(SessionProtocol.CREATE, filters);
		return null;
	}

	public function list()
	{

	}

	public function get(?filters:Array<Filter<Dynamic>>):Session
	{
		var action = new SessionAction(SessionProtocol.GET, filters);
		
		var bytes = SessionAction.serialize(action);
		send(bytes);

		return null;
	}

	public function close()
	{
		//data(CLOSE);
	}
}
