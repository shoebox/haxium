package haxium.server;

import haxe.crypto.Md5;
import haxium.protocol.filter.Filter;
import haxium.protocol.session.SessionProtocol;
import haxium.protocol.session.SessionProtocol.SessionAction;

import haxium.server.Client;

class Sessions
{
	var list:Array<Session>;
	var map:Map<String, Session>;

	public function new()
	{
		list = [];
		map = new Map();
	}

	public function execute(client:Client, action:SessionAction)
	{
		var session:Session = null;
		switch (action.type)
		{
			case SessionProtocol.CLOSE:

			case SessionProtocol.CREATE:
				session = createSession(client, action.filters);
			
			case SessionProtocol.GET:
				session = findSession(action.filters);
				
			case SessionProtocol.LIST:
		}
	}

	function createSession(client:Client, 
		filter:Array<Filter<Dynamic>>):Session
	{
		trace("createSession");
		var session = new Session(client, filter);
		map.set(session.id, session);
		return session;
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
			for (filter in filters)
			{
				switch (filter.filter)
				{
					case ABSTRACT | PACKAGE: //TODO:Package handling
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

	function compareAbstract(value1:Dynamic, value2:Dynamic, 
		condition:FilterCondition)
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

class Session
{
	public var client(default, null):Client;
	public var filters(default, null):Array<Filter<Dynamic>>;
	public var id(default, null):String;

	public function new(client:Client, filters:Array<Filter<Dynamic>>)
	{
		this.client = client;
		this.filters = filters;
		this.id = Md5.encode(Date.now().toString());
	}
}
