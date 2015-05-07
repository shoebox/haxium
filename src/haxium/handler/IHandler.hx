package haxium.handler;

import haxium.protocol.command.Command;
import haxium.protocol.command.ElementFilter;
import haxium.protocol.element.Bounds;
import haxium.protocol.Property;

interface IHandler<C>
{
	function getProperty(child:C, propertyName:String):Null<Property>;
	function setProperty(child:C, propertyName:String, value:Dynamic):Bool;
	function getChild(by:ElementFilter):Array<C>;
	function getChildBounds(child:C):Bounds;
	function getChildAutomationName(child:C):String;
}
