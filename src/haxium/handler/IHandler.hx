package haxium.handler;

import haxium.protocol.command.Command;
import haxium.protocol.command.ElementFilter;
import haxium.protocol.element.Bounds;

interface IHandler<C>
{
	function getProperty(child:C, propertyName:String):Null<Dynamic>;
	function setProperty(child:C, propertyName:String, value:Dynamic):Bool;
	function getChild(by:ElementFilter):Null<C>;
	function getChildBounds(child:C):Bounds;
}
