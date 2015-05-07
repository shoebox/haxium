package haxium.handler;

// import haxium.plugin.IHandler.HandlerResponse;
// import haxium.protocol.By;
// import haxium.protocol.Command;
// import haxium.protocol.DeviceCommand;
// import haxium.protocol.ElementCommand;
// import haxium.protocol.handler.IHandler;
// import haxium.protocol.Property;
// import haxium.protocol.SessionCommand;
// import mui.event.Touch;
// import mui.Lib;
// import openfl.display.DisplayObject;
// import openfl.display.DisplayObjectContainer;
// import openfl.events.MouseEvent;
// import openfl.geom.Point;
// import openfl.Lib;
import haxium.handler.IDevice;
import haxium.handler.IHandler;
import haxium.protocol.command.Command;
import haxium.protocol.command.ElementFilter;
import haxium.protocol.command.ResponseCommand;
import haxium.protocol.element.Bounds;
import haxium.util.Log;
import mui.display.Display;
import haxium.protocol.Property;
import haxium.protocol.TouchType;

class MuiHandler implements IHandler<Display> implements ITouchDevice
{
	public function new()
	{
	}

	// ITouchDevice ------------------------------------------------------------

	public function drag(startX:Int, startY:Int, endX:Int, endY:Int, 
		duration:Float, steps:Int):Bool
	{
		return false;
	}

	public function touch(x:Int, y:Int, type:TouchType):Bool
	{
		// TODO(Johann)
		var root = mui.Lib.display;
		var touch = new mui.event.Touch(x, y);
		mui.event.Touch.start(touch);
		touch.complete();

		return true;
	}

	// IHandler ----------------------------------------------------------------

	public function getProperty(child:Display, propertyName:String):Null<Property>
	{
		var result:Property = null;
		var value:Dynamic = null;
		var propertyType:PropertyType;
		try
		{
			value = Reflect.getProperty(child, propertyName);
			if (Std.is(value, Display))
			{
				propertyType = PropertyType.Element;
				value = getChildAutomationName(value);
			}
			else
			{
				propertyType = PropertyType.Variable;
			}

			if (value != null)
			{
				result = 
				{
					type : propertyType,
					value : value
				};
			}
		}
		catch (exception:Dynamic)
		{
			// TODO(Johann)
			result = null;
		}
		
		return result;
	}

	public function setProperty(child:Display, propertyName:String, value:Dynamic):Bool
	{
		var result = true;
		try
		{
			Reflect.setProperty(child, propertyName, value);
		}
		catch (exception:Dynamic)
		{
			result = false;
		}
		return result;
	}

	public function getChild(by:ElementFilter):Array<Display>
	{
		var root = mui.Lib.display;
		var result = forEachChild(root, [], by);
		return result;
	}

	public function getChildBounds(child:Display):Bounds
	{
		var result:Bounds = {
			x:child.rootX, 
			y:child.rootY, 
			width:child.width, 
			height:child.height
		};
		return result;
	}

	function forEachChild(display:Display, result:Array<Display>, ?by:ElementFilter):Array<Display>
	{
		var valid:Bool;
		for (child in display.iterator())
		{
			valid = testChildAgainst(child, by);
			if (valid) result.push(child);
			forEachChild(child, result, by);
		}

		return result;
	}

	function testChildAgainst(child:Display, ?by:Null<ElementFilter>):Bool
	{
		var result = false;
		switch (by)
		{
			case ElementId(id) : 
				result = getChildAutomationName(child) == id;

			case ElementType(name) : 
				result = getFullChildClass(child) == name;
				
			case null : 
				result = true;

			default:
		}
		return result;
	}

	public function getChildAutomationName(child:Display):String
	{
		var className = getChildClass(child);
		var result:String = "" + getIndex(child);
		var display:Display = child.parent;
		var className:String;
		while (display != null)
		{
			className = getChildClass(display) + getIndex(display);
			result =  className + ":" + result;
			display = display.parent;
		}

		result = getChildClass(child) + "_" + haxe.crypto.Md5.encode(result);
		
		return result;
	}

	function getIndex(child:Display):Int
	{
		var index = child.index;
		return index;
	}

	function getChildClass(child:Display):String
	{
		var result = getFullChildClass(child);
		return result.split(".").pop();
	}

	function getFullChildClass(child:Display):String
	{
		var ref:Class<Dynamic> = Type.getClass(child);
		var result = Type.getClassName(ref);
		return result;
	}
}
