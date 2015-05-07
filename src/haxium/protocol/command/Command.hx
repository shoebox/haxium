package haxium.protocol.command;

import haxium.protocol.TouchType;

enum Command
{
	// Device
	Drag(startX:Int, startY:Int, endX:Int, endY:Int, duration:Float, steps:Int);
	Press(x:Int, y:Int);
	Tap(x:Int, y:Int);
	Touch(x:Int, y:Int, type:TouchType);

	// Element
	GetProperty(childName:String, name:String);
	SetProperty(childName:String, name:String, value:Dynamic);
	GetChild(by:ElementFilter);
	GetBounds(childName:String);
}

