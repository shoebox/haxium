package haxium.protocol;

enum ElementCommand
{
	Clear;
	Click;
	GetBounds(?bounds:ElementBounds);
	GetText;
	SetText(?text:String);
}

typedef ElementBounds=
{
	public var position:ElementPosition;
	public var width:Float;
	public var height:Float;
}

typedef ElementPosition=
{
	public var x:Float;
	public var y:Float;
}
