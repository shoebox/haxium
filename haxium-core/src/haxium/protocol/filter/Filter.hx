package haxium.protocol.filter;

import haxe.io.Bytes;
import haxe.io.BytesInput;
import haxe.io.BytesOutput;

import haxe.Serializer;
import haxe.Unserializer;
import haxium.protocol.session.SessionSpec;

import haxium.Serializable;

typedef DFilter = Filter<Dynamic>;
typedef DFilters = Array<DFilter>;

class Filter<T> implements Serializable
{
	public var spec:SessionSpecType;
	public var condition:FilterCondition;
	public var value:T;

	public static inline var ID = 0x001;

	public function new(spec:SessionSpecType, value:T, 
		?condition:FilterCondition)
	{
		this.spec = spec;
		this.condition = condition;
		this.value = value;
	}

	public function getCode():Int
	{
		return ID;
	}

	public function serialize():Bytes
	{
		var raw = Serializer.run(value);
		var datas = Bytes.ofString(raw);

		var output = new BytesOutput();
		output.writeInt32(ID);
		output.writeInt32(Type.enumIndex(spec));
		output.writeInt32(Type.enumIndex(condition));
		output.writeInt32(datas.length);
		output.write(datas);

		return output.getBytes();
	}

	public static function unserialize(datas:BytesInput):DFilter
	{
		var id = datas.readInt32();
		if (id != ID)
			throw "Invalid datas";

		id = datas.readInt32();
		var spec = Type.allEnums(SessionSpecType)[id];

		id = datas.readInt32();
		var condition = Type.allEnums(FilterCondition)[id];

		var len = datas.readInt32();
		var raw = datas.readString(len);

		var result = Unserializer.run(raw);
		return result;
	}

	public static function serializeArray(list:Array<DFilter>):Bytes
	{
		return null;	
	}

	public static function unserializeArray(input:BytesInput, 
		?result:Array<DFilter>):Array<DFilter>
	{
		return [];
	}

	public function toString():String
	{
		return '[Filter ' + spec + " | " + condition + " | " + value + "]";
	}
}

enum FilterCondition
{
	EQUAL;
	INF;
	SUP;
}
