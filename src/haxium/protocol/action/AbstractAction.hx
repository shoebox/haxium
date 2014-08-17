package haxium.protocol.action;

import haxium.protocol.action.AbstractAction;
import haxium.protocol.action.SessionAction;

class AbstractAction
{
	public var type:SessionActionType;

	public function new(type:SessionActionType)
	{
		this.type = type;
	}
}
