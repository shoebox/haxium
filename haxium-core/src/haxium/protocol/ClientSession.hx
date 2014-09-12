package haxium.protocol;

import haxium.protocol.session.SessionSpec;
import haxium.utils.HaxiumUtil;

class ClientSession
{
	public var hooked(default, default):Bool;
	public var id(default, null):String;
	public var specs(default, null):DSessionSpecs;

	public function new(specs:DSessionSpecs)
	{
		this.hooked = false;
		this.id = HaxiumUtil.ID();
		this.specs = specs;	
	}	
}
