package haxium.server;

import haxe.io.Bytes;

class Protocol
{
	public static inline var SESSION_CREATE = 0x100;
	public static inline var SESSION_LIST = 0x101;
	public static inline var SESSION_GET = 0x102;
	public static inline var SESSION_CLOSE = 0x103;
	
	public static function parse(bytes:Bytes)
	{
		trace("parse ::: " + bytes);
	}
}
