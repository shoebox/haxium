package haxium.protocol;

import haxium.protocol.filter.Filter;

class SessionRef
{
	public var id(default, null):String
	public var filters(default, null):Array<DFilter>;

	public function new(id:String, filters:Array<DFilter>)
	{
		this.id = id;
		this.filters = filters;
	}
}
