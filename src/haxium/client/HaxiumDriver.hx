package haxium.client;

import haxe.io.Bytes;
import haxe.Serializer;
import haxium.protocol.action.SessionAction;
import haxium.protocol.filter.Filter;
import haxium.protocol.ActionType;
import haxium.protocol.SessionProtocol;
import haxium.utils.HaxiumSocket;
import msignal.Signal.Signal0;

class HaxiumDriver extends HaxiumSocket
{
	public var connected:Signal0;

	public function new()
	{
		super();
		connected = new Signal0();
	}

	override public function connect(host:String, port:Int)
	{
		super.connect(host, port);
	}

	override function whenConnected(_)
	{
		super.whenConnected(null);
		createSession();
	}

	public function createSession()
	{
		trace("createSession");
		var filters = [new Filter<String>(PACKAGE, EQUAL, "org.shoebox.haxium")];
		var action = new SessionAction(CREATE, filters);
		var s = Serializer.run(action);
		trace(s);
		send(Bytes.ofString(s));
	}
}
