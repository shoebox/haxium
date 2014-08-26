package haxium.protocol.filter;

import haxe.io.Bytes;
import haxe.io.BytesInput;
import haxe.io.BytesOutput;

class Filter<T>
{
	public var filter:FilterType;
	public var condition:FilterCondition;
	public var value:T;

	public function new(filter:FilterType, value:T, 
		?condition:FilterCondition)
	{
		this.filter = filter;
		this.condition = condition;
		this.value = value;
	}

	public function serialize():Bytes
	{
		var output = new BytesOutput();
		output.writeByte(Type.enumIndex(filter));
		output.writeByte(Type.enumIndex(condition));

		var bytes = Bytes.ofString(value + "");
		output.writeInt32(bytes.length);
		output.write(bytes);
		return output.getBytes();
	}

	public static function deserialize(bytes:BytesInput):Filter<Dynamic>
	{
		var filterType = Type.allEnums(FilterType)[bytes.readByte()];
		var condition = Type.allEnums(FilterCondition)[bytes.readByte()];
		var len = bytes.readInt32();
		var value = bytes.read(len);
		var result = new Filter<Dynamic>(filterType, 
			value.toString(), condition);
		return result;
	}

	public function toString():String
	{
		return '[Filter ' + filter + " | " + condition + " | " + value + "]";
	}
}

enum FilterType
{
	ABSTRACT;
	PACKAGE;
	VERSION;
}

enum FilterCondition
{
	EQUAL;
	INF;
	SUP;
}
