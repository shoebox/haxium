package haxium.handler;

import haxium.protocol.TouchType;

interface IDevice
{
	function getSystemProperty(property:String):Dynamic;
	function getSystemVariable(variable:String):Dynamic;
	function installPackage(packagePath:String):Bool;
	function reboot():Void;
	function removePackage(packageName:String):Bool;
	function shell(command:String):Dynamic;
	function type(message:String):Bool;
	function wake():Void;
}

interface ITouchDevice
{
	function drag(startX:Int, startY:Int, endX:Int, endY:Int, duration:Float, steps:Int):Bool;
	function touch(x:Int, y:Int, type:TouchType):Bool;
}

