package haxium.driver;

import haxe.io.Bytes;

import haxium.protocol.session.SessionSpec;
import haxium.protocol.RemoteProtocol;
import haxium.utils.HaxiumSocket;
import msignal.Signal.Signal0;

class Driver extends HaxiumSocket
{
	public var sessionCreated(default, null):Signal0;

	public function new()
	{
		super();
		sessionCreated = new Signal0();
	}

	public function create(specs:SessionSpec)
	{
		RemoteProtocol.create(this, specs.get());
		return this;
	}

	override function onRawDatas(bytes:Bytes)
	{
		var request = RemoteProtocol.getFromBytes(bytes);
		switch (request.action)
		{
			case RemoteProtocol.CREATED:
				sessionCreated.dispatch();

			default:
		}
	}
}
