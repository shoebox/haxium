package haxium.protocol.filter;

import haxium.protocol.filter.FilterCondition;
import haxium.protocol.filter.FilterType;

class Filter<T>
{
	public var filter:FilterType;
	public var condition:FilterCondition;
	public var value:T;

	public function new(filter:FilterType, condition:FilterCondition, value:T)
	{
		this.filter = filter;
		this.condition = condition;
		this.value = value;
	}

	public function toString():String
	{
		return '[Filter | ' + filter + " | " + condition + " | " + value + "]";
	}
}
