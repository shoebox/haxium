package haxium.protocol;

import haxe.crypto.Md5;

import haxium.protocol.action.SessionAction.SessionActionType;
import haxium.protocol.filter.Filter;

class Session
{
	public var id(default, null):String;
	public var expirationDate(default, null):Date;
	public var status(default, null):SessionActionType;
	public var filters(default, null):Array<Filter<Dynamic>>;

	public function new(?filters:Array<Filter<Dynamic>>)
	{
		var date = Date.now();

		this.expirationDate = Date.fromTime(date.getTime() + 1800000);
		this.filters = filters;
		this.id = Md5.encode(date.toString());
		this.status = CREATED;
	}
}
