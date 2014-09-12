package haxium.protocol;

import haxe.io.Bytes;
import haxe.io.BytesOutput;
import haxe.Serializer;
import haxium.protocol.filter.Filter;

typedef SessionList=Array<Session>;

class Session
{
	public var filters:DFilters;
	public var hooked(default, null):Bool;
	public var id(default, null):String;
	
	public function new(id:String, ?filters:DFilters)
	{
		this.id = id;
		this.filters = filters;
	}

	public function hook()
	{
		hooked = true;
	}
}
