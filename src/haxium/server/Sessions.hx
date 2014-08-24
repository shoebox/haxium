package haxium.server;

import haxe.Serializer;
import haxe.crypto.Md5;
import haxe.io.Bytes;

import haxium.protocol.action.SessionAction;
import haxium.protocol.filter.Filter;
import haxium.protocol.filter.FilterCondition;
import haxium.protocol.filter.FilterType;
import haxium.protocol.Session;
import haxium.server.RemoteClient;
import haxium.utils.HaxiumSocket;

class Sessions
{
	var list:Array<Session>;

	public function new()
	{
		list = [];
	}

	public function execute(action:SessionAction, client:RemoteClient)
	{
		var result:Dynamic = null;
		switch (action.type)
		{
			case CREATE:
				result = new Session(action.filters);
				list.push(result);

			case SELECT:
				result = findSession(action.filters);

			case LIST:
				result = findSessions(action.filters);
		
			default:
		}

		var data = Serializer.run(result);
		var bytes = Bytes.ofString(data);

		if (bytes != null)
		{
			client.socket.output.writeInt32(bytes.length);
			client.socket.output.write(bytes);
		}

		return null;
	}

	function findSessions(filters:Array<Filter<Dynamic>>):Array<Session>
	{
		var result = [];
		for (session in list)
		{
			if (testFilter(session, filters))
				result.push(session);
		}
	
		return result;
	}

	function findSession(filters:Array<Filter<Dynamic>>):Null<Session>
	{
		var result = false;
		for (session in list)
		{
			result = testFilter(session, filters);
			if (result)
				return session;
		}

		return null;
	}

	function testFilter(session:Session, 
		filters:Array<Filter<Dynamic>>):Bool
	{
		var result = true;
		for (sessionFilter in session.filters)
		{
			for(filter in filters)
			{
				switch(filter.filter)
				{
					case ABSTRACT | PACKAGE:
						result = compareAbstract(sessionFilter.value, 
							filter.value, filter.condition);

					case VERSION:
				}

				if (!result)
					break;
			}
		}
		
		return result;
	}

	function compareAbstract(value1:Dynamic, value2:Dynamic, condition:FilterCondition)
	{
		var result = false;
		switch (condition)
		{
			case EQUAL:
				result = value1 == value2;

			default:
		}

		return result;
	}
}
