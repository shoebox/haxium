package haxium.server;

import haxe.io.Bytes;
import haxium.protocol.action.SessionAction;

class Sessions
{
	public function new()
	{

	}

	public function execute(action:SessionAction)
	{
		switch (action.type)
		{
			case CREATE:
				trace("create");

			default:
		}
	}
}