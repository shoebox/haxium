package haxium.protocol;

enum ElementCommand
{
	Clear;
	Click;
	GetBounds;
	GetText;
	SetText(?text:String);
	GetProperty(property:String);
	SetProperty(property:String, value:Dynamic);
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
