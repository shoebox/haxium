package haxium.protocol.command;

import haxium.protocol.element.Bounds;
import haxium.protocol.Property;

enum ResponseCommand
{
	GetChilds(list:Array<String>);
	GetBounds(bounds:Bounds);
	GetProperty(property:Property);
	Valid;
	Invalid;
}
