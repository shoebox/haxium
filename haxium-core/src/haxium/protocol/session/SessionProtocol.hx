package haxium.protocol.session;

import haxe.io.Bytes;
import haxe.io.BytesInput;
import haxe.io.BytesOutput;

import haxium.protocol.filter.Filter;

class SessionProtocol
{
	public static inline var CREATE = 0x100;
	public static inline var CLOSE = 0x101;
	public static inline var JOIN = 0x102;
	public static inline var LIST = 0x103;
	public static inline var GET = 0x104;
	public static inline var RESPONSE = 0x105;

	public function new()
	{

	}
}

class SessionAction
{
	public var filters(default, null):Array<Filter<Dynamic>>;
	public var type(default, null):Int;

	public function new(type:Int, 
		?filters:Array<Filter<Dynamic>>)
	{
		this.type = type;
		this.filters = filters;
	}

	public function toString():String
	{
		return '[SessionAction : $type | filters: $filters]';
	}

	public static function serialize(action:SessionAction):Bytes
	{
		var output = new BytesOutput();
		output.writeInt32(action.type);
		output.writeInt32(action.filters == null ? 0 : 
			action.filters.length);

		var bytes:Bytes;
		if (action.filters != null)
		{
			for (filter in action.filters)
			{
				bytes = filter.serialize();
				output.write(bytes);
			}
		}

		return output.getBytes();
	}	

	public static function deserialize(bytes:Bytes):SessionAction
	{
		var input = new BytesInput(bytes);
		input.position = 0;

		var type = input.readInt32();
		var len = input.readInt32();

		var filter:Filter<Dynamic>;
		var filters:Array<Filter<Dynamic>> = [];
		for (i in 0...len)
		{
			filter = Filter.deserialize(input);
			filters.push(filter);
		}

		return new SessionAction(type, filters);
	}
}
