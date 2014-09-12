package haxium.server;

import haxium.protocol.ClientSession;
import haxium.protocol.Hook;
import haxium.protocol.filter.Filter;
import haxium.protocol.session.SessionSpec;

#if flash
import flash.net.Socket;
#else
import sys.net.Socket;
#end

class Sessions
{
	var list:Array<ClientSession>;
	var sockets:Map<String, Socket>;

	public function new()
	{
		list = [];
		sockets = new Map();
	}

	public function create(specs:DSessionSpecs, socket:Socket):ClientSession
	{
		var session = new ClientSession(specs);
		list.push(session);
		sockets.set(session.id, socket);
		return session;
	}

	public function get(filters:DFilters):Array<ClientSession>
	{
		var result = [];
		for (session in list)
		{
			if (testSessionFor(session, filters))
				result.push(session);
		}

		return result;
	}

	public function hook(filters:DFilters):Hook
	{
		var sessions = get(filters);
		var hook = new Hook(sessions);

		return hook;
	}

	inline function testSessionFor(session:ClientSession, filters:DFilters):Bool
	{
		var result = true;
		for (filter in filters)
		{
			for (spec in session.specs)
			{
				if (spec.type == filter.spec)
				{
					result = switch (filter.condition)
					{
						case EQUAL:
							spec.value == filter.value;

						case INF:
							//TODO
							spec.value < filter.value;

						case SUP:
							//TODO
							spec.value > filter.value;
					}
				}
			}

			if (!result)
				break;
		}

		return result;
	}
}
