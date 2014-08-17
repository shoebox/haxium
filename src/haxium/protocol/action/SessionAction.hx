package haxium.protocol.action;

import haxium.protocol.action.AbstractAction;
import haxium.protocol.filter.Filter;

class SessionAction extends AbstractAction
{
	public var filters:Array<Filter<Dynamic>>;

	public function new(type:SessionActionType, filters:Array<Filter<Dynamic>>)
	{
		super(type);
		this.type = type;
		this.filters = filters;
	}
}

enum SessionActionType
{
	CREATE;
}
