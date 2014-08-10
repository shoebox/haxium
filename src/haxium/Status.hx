package haxium;

import haxium.Haxium;

class Status
{
	public var haxium(default, null):Haxium;

	public function new(haxium:Haxium)
	{
		this.haxium = haxium;
	}

	public function get()
	{
		trace("get");
		haxium.whenDatas.add(onDatas);
		haxium.send("status", "GET");
	}

	function onDatas(data:String)
	{
		trace("onDatas :::: "+ data);
	}
}
