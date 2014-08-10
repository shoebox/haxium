package haxium;

import haxium.session.Session;
import haxium.Connection;
import haxium.Status;

class Haxium extends Connection
{
	public var status(default, null):Status;

	public function new()
	{
		super();
		whenConnected.add(whenSocketConnected);
		status = new Status(this);
	}

	function whenSocketConnected()
	{
		status.get();
	}
}
