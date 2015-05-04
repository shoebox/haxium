package haxium.protocol;

class Protocol
{

}

typedef Bounds=
{
	public var x:Int;
	public var y:Int;
	public var w:Int;
	public var h:Int;
}

enum ElementBy
{
	Id(id:String);
	Type(type:String);
}
