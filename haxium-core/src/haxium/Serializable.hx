package haxium;

import haxe.io.Bytes;

interface Serializable
{
	public function serialize():Bytes;
	public function getCode():Int;
}
