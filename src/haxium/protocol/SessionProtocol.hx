package haxium.protocol;

import haxium.protocol.Session;
import haxium.protocol.action.SessionAction;
import haxium.protocol.filter.Filter;
import haxium.protocol.filter.FilterCondition;
import haxium.protocol.filter.FilterType;
import haxium.protocol.SessionProtocol;
import haxium.utils.HaxiumSocket;

class SessionProtocol
{
	public static function create()
	{
		trace('create');
	}	

	public static function select(socket:HaxiumSocket, 
		?filter:Array<Filter<Dynamic>>):Session
	{
		var action = new SessionAction(SELECT, filter);
		socket.sendAction(action);
		
		return null;
	}

	public static function list(socket:HaxiumSocket, 
		?filters:Array<Filter<Dynamic>>):Array<Session>
	{
		var action = new SessionAction(LIST, filters);
		socket.sendAction(action);

		return null;
	}

	public static function close(session:Session)
	{

	}
}
