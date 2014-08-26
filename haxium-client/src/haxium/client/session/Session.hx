package haxium.client.session;

//import haxium.protocol.filter.Filter;

class Session
{
	public var id(default, null):String;

	public function new(id:String)
	{
		this.id = id;
	}
}
