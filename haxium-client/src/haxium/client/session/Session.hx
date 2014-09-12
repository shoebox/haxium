package haxium.client.session;

import haxe.io.Bytes;

import haxe.Serializer;
import haxium.Serializable;

//import haxium.protocol.filter.Filter;

class Session implements Serializable
{
	public var id(default, null):String;

	public function new(id:String)
	{
		this.id = id;
	}

	public function serialize():Bytes
	{
		var datas = Serializer.run(this);
		return Bytes.ofString(datas);
	}
}
