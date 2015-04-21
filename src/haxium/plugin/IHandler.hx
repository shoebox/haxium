package haxium.plugin;

import haxium.protocol.By;
import haxium.protocol.Command;
import haxium.protocol.Protocol;

interface IHandler
{
	public function onMessage(message:Command):Null<Dynamic>;
	public function elements(?by:By):Command;
}

typedef HandlerResponse=
{
	var handled:Bool;
	var result:Null<Dynamic>;
}
