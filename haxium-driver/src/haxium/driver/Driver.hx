package haxium.driver;

import haxe.io.Bytes;

import haxium.protocol.session.SessionSpec;
import haxium.protocol.RemoteProtocol;
import haxium.utils.HaxiumSocket;

class Driver extends HaxiumSocket
{
	public function new()
	{
		super();
	}

	public function create(specs:SessionSpec)
	{
		RemoteProtocol.create(this, specs.get());
	}

	override function onRawDatas(bytes:Bytes)
	{
		trace("onRawDatas");
	}
}
