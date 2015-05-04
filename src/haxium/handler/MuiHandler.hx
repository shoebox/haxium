package haxium.handler;

import haxium.handler.IHandler;

// import haxium.plugin.IHandler.HandlerResponse;
// import haxium.protocol.By;
// import haxium.protocol.Command;
// import haxium.protocol.DeviceCommand;
// import haxium.protocol.ElementCommand;
// import haxium.protocol.Property;
// import haxium.protocol.SessionCommand;

// import mui.Lib;
import mui.display.Display;
// import mui.event.Touch;

// #if openfl
// import openfl.Lib;
// import openfl.display.DisplayObject;
// import openfl.display.DisplayObjectContainer;
// import openfl.events.MouseEvent;
// import openfl.geom.Point;
// #end

// import haxium.protocol.handler.IHandler;
import haxium.protocol.command.Command;
import haxium.protocol.Protocol;
import haxium.protocol.command.ElementFilter;
import haxium.protocol.element.Bounds;

class MuiHandler implements IHandler<Display>
{
	public function new()
	{
	}

	public function getProperty(child:Display, propertyName:String):Null<Dynamic>
	{
		return null;
	}

	public function setProperty(child:Display, propertyName:String, value:Dynamic):Bool
	{
		return false;
	}

	public function getChild(by:ElementFilter):Null<Display>
	{
		trace("getChild ::: "+ by);
		return null;
	}

	public function getChildBounds(child:Display):Bounds
	{
		return {x:0, y:0, width:0, height:0};
	}

	public function tap(x:Int, y:Int):Bool
	{
		return false;
	}

	// public function onMessage(message:Command):Null<Dynamic>
	// {
	// 	var result = switch (message)
	// 	{
	// 		case Command.DeviceAction(command) : deviceCommand(command);
	// 		case Command.Elements(by) : elements(by);
	// 		case Command.ElementCommand(id, action) : elementCommand(id, action);
	// 		case Command.SessionAction(command) : sessionAction(command);
	// 		default : null;
	// 	}
	// 	return result;
	// }

	// public function elementCommand(id:String, action:ElementCommand):Dynamic
	// {
	// 	var child:Null<Display> = getChildById(id);
	// 	if (child == null) return null;

	// 	var result:Dynamic = switch (action)
	// 	{
	// 		case SetProperty(id, value) : setProperty(child, id, value);
	// 		case GetProperty(id) : getProperty(child, id);
	// 		case GetBounds:
	// 		{
	// 			position : 
	// 			{
	// 				x : child.rootX, 
	// 				y : child.rootY
	// 			}, 
	// 			width : child.width,
	// 			height : child.height
	// 		};
	// 		default : null;
	// 	}
	// 	return result;
	// }

	// function sessionAction(command:SessionCommand):Dynamic
	// {
	// 	trace("sessionAction ::: " + command);
	// 	var result:Dynamic = null;
	// 	var root = mui.Lib.display;
	// 	switch (command)
	// 	{
	// 		case SessionCommand.GetUrl : 
	// 	}
	// 	return result;
	// }

	// function deviceCommand(command:DeviceCommand):Dynamic
	// {
	// 	var result = false;
	// 	switch (command)
	// 	{
	// 		case DeviceCommand.Click(stageX, stageY):
	// 			var root = mui.Lib.display;
	// 			var touch = new Touch(stageX, stageY);
	// 			Touch.start(touch);
	// 			touch.complete();
	// 			result = true;

	// 		default : 
	// 			result = false;
	// 	}

	// 	return result;
	// }

	// function getChildById(id:String):Null<Display>
	// {
	// 	var root = mui.Lib.display;
	// 	var list:Array<Display> = [];
	// 	var childs = forEach(root, list, By.ElementId(id));

	// 	var result:Null<Display> = null;
	// 	if (childs.length > 0)
	// 		result = childs[0];
		
	// 	return result;
	// }

	// function getProperty(child:Null<Display>, property:String):Dynamic
	// {
	// 	var result:Property = null;
	// 	var propertyType:PropertyType = Variable;
	// 	var value:Dynamic = null;
	// 	try
	// 	{
	// 		value = Reflect.getProperty(child, property);
	// 	}
	// 	catch (exception:Dynamic)
	// 	{

	// 	}
		
	// 	if (Std.is(value, Display))
	// 	{
	// 		propertyType = PropertyType.Element;
	// 		value = getChildAutomationName(value);
	// 	}

	// 	var result:Dynamic = null;

	// 	if (value != null)
	// 	{
	// 		result = {
	// 			type : propertyType,
	// 			value : value
	// 		};
	// 	}
	// 	return result;
	// }

	// function setProperty(child:Null<Display>, property:String, value:Dynamic):Dynamic
	// {
	// 	var result = true;
	// 	try
	// 	{
	// 		Reflect.setProperty(child, property, value);
	// 	}
	// 	catch (exception:Dynamic)
	// 	{
	// 		result = false;
	// 	}
	// 	return result;
	// }

	// public function elements(?by:By):Dynamic
	// {
	// 	var list:Array<Display> = [];
	// 	var root = mui.Lib.display;
	// 	list = forEach(root, list, by);
		
	// 	var names = [for (child in list) getChildAutomationName(child)];
	// 	var command = Command.ElementsResult(names);
	// 	return command;
	// }

	// function forEach(display:Display, result:Array<Display>, ?by:By):Array<Display>
	// {
	// 	var valid:Bool;
	// 	for (child in display.iterator())
	// 	{
	// 		valid = testChildAgainst(child, by);
	// 		if (valid) result.push(child);
	// 		forEach(child, result, by);
	// 	}

	// 	return result;
	// }

	// function testChildAgainst(child:Display, ?by:Null<By>):Bool
	// {
	// 	var result:Bool = switch (by)
	// 	{
	// 		case ElementId(id) : getChildAutomationName(child) == id;
	// 		case ElementType(name) : getClassName(child) == name;
	// 		case null : true;
	// 		default : false;
	// 	}
	// 	return result;
	// }

	// function getLastClassName(child:Display):String
	// {
	// 	var result = getClassName(child);
	// 	return result.split(".").pop();
	// }

	// function getClassName(child:Display):String
	// {
	// 	var displayClass = Type.getClass(child);
	// 	var name = Type.getClassName(displayClass);
	// 	return name;
	// }

	// function getChildAutomationName(child:Display):String
	// {
	// 	var target = child;
	// 	var parent = child.parent;
	// 	var result = getLastClassName(child) + getIndex(parent);
	// 	if (parent != null)
	// 	{
	// 		result = getLastClassName(child) + getIndex(parent) + " : " + result;
	// 	}

	// 	// var result = getLastClassName(child);
	// 	// var p = child.parent;
	// 	// var id = child;
	// 	// if (p != null) result = getLastClassName(p)+ "->" + result;
	// 	// var depth = 0;
	// 	// try
	// 	// {
	// 	// 	depth = p != null ? p.getChildIndex(child) : child.rootX + child.rootY;
	// 	// }
	// 	// catch (e:Dynamic){}
	// 	return result;
	// }

	// function getIndex(child:Display):Int
	// {
	// 	var index = child.index;
	// 	return index;
	// }
}
