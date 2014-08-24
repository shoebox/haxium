package haxium.client;

import haxe.Unserializer;
import haxium.protocol.action.SessionAction;
import haxium.protocol.filter.FilterCondition;
import haxium.protocol.filter.FilterType;
import haxium.protocol.filter.Filter;
import haxium.protocol.Session;
import haxium.protocol.SessionProtocol;
import haxium.server.Sessions;
import haxium.utils.HaxiumSocket;

class HaxiumClient extends HaxiumSocket
{
	public function new()
	{
		super();
		//mutex = new Mutex();
	}

	public function session(?filters:Array<Filter<Dynamic>>):Session
	{
		SessionProtocol.select(this, filters);
		
		var session:Session = readObject();
		return session;
	}

	public function sessions(filters:Array<Filter<Dynamic>>):Array<Session>
	{
		trace("sessions");
		SessionProtocol.list(this, filters);

		var list:Array<Session> = readObject();
		trace("list ::::" + list);
		return list;
	}

	function readObject():Dynamic
	{
		var len = socket.input.readInt32();
		var datas = socket.input.read(len);
		var result = Unserializer.run(datas.toString());
		return result;
	}
}
