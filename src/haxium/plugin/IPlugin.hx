package haxium.plugin;

import haxium.Protocol.Command;

interface IPlugin
{
	public function onMessage(message:Command):Bool;
}
