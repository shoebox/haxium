package haxium.protocol.session;

import haxe.io.Bytes;
import haxe.io.BytesInput;
import haxe.io.BytesOutput;

import haxe.Serializer;
import haxe.Unserializer;
import haxium.protocol.filter.Filter;
import haxium.Serializable;

class SessionProtocol
{
	public static inline var CREATE = 0x100;
	public static inline var CLOSE = 0x102;
	public static inline var JOIN = 0x104;
	public static inline var LIST = 0x105;
	public static inline var GET = 0x106;
	public static inline var RESPONSE = 0x107;

	public function new()
	{

	}
}

class SessionAction implements Serializable
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

	public function serialize():Bytes
	{
		var result = Serializer.run(this);
		var raw = Bytes.ofString(result);

		var output = new BytesOutput();
		output.writeInt32(raw.length);
		output.write(raw);

		return Bytes.ofString(result);
	}	
}
