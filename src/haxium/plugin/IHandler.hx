package haxium.plugin;

import haxium.protocol.Command;
import haxium.protocol.Protocol;

interface IHandler
{
	public function onMessage(message:Command):HandlerResponse;
}

typedef HandlerResponse=
{
	var handled:Bool;
	var command:Command;
}
