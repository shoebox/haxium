package haxium.driver;

import haxium.utils.HaxiumSocket;
import haxium.protocol.session.SessionProtocol;

class Driver extends HaxiumSocket
{
	public function new()
	{
		super();
	}

	override function whenConnected(_)
	{
		super.whenConnected(null);
		trace("whenConnected");

		var action = new SessionAction(SessionProtocol.CREATE);
		send(SessionAction.serialize(action));
	}
}
