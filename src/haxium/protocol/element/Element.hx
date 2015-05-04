package haxium.protocol.element;

import haxium.protocol.command.Command;
import haxium.protocol.element.Bounds;
import haxium.protocol.Property;
import haxium.Server;
import haxium.Device;

class Element
{
	public var bounds(get, null):Bounds;
	function get_bounds():Bounds
	{
		var command = Command.GetBounds(id);
		var result = runCommand(command);
		var bounds:Bounds = cast result;
		return bounds;
	}

	public var device(default, null):Device;
	public var id(default, null):String;
	
	public function new(id:String, device:Device)
	{
		this.device = device;
		this.id = id;
	}

	public function toString():String
	{
		return "Element ::: " + id;
	}

	function runCommand(command:Dynamic):Dynamic
	{	
		device.server.writeCommand(command);
		var result = device.server.readCommand();
		return result;
	}

	// Element command ----------------------------------------------------------

	public function setProperty(property:String, value:Dynamic)
	{
		var command = Command.SetProperty(id, property, value);
		var result = runCommand(command);
		// TODO(Johann) : Test for result
	}

	public function getProperty(property:String):Dynamic
	{
		var command = Command.GetProperty(id, property);
		var property:Property = runCommand(command);	
		var result:Dynamic = null;
		if (property.type == PropertyType.Element)
		{
			result = new Element(property.value, device);
		}
		else
		{
			result = property.value;
		}

		return result;
	}

	// Device command ----------------------------------------------------------

	public function press():Bool
	{
		var center = getCenter();
		var result = device.press(center.x, center.y);
		return result;
	}

	public function tap():Bool
	{
		var center = getCenter();
		var result = device.tap(center.x, center.y);
		return result;
	}

	public function touch(type:TouchType):Bool
	{
		var center = getCenter();
		var result = device.touch(center.x, center.y, type);
		return result;
	}

	function getCenter():Point
	{
		var rect = this.bounds;
		var x = Std.int(rect.x + rect.width / 2);
		var y = Std.int(rect.y + rect.height / 2);
		return {x:x, y:y};
	}
}

typedef Point=
{
	var x:Int;
	var y:Int;
}
