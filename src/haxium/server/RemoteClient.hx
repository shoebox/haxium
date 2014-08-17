package haxium.server;

class RemoteClient
{
	public var id:String;
	public var expiry:Date;

	public function new()
	{
		expiry = Date.now();
		id = haxe.crypto.Md5.encode(expiry.toString());
	}
}
