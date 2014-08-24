package haxium.driver;

import haxe.io.Bytes;

import haxe.Serializer;

import haxium.protocol.action.SessionAction;
import haxium.protocol.ActionType;
import haxium.protocol.filter.Filter;
import haxium.protocol.SessionProtocol;
import haxium.utils.HaxiumSocket;

import msignal.Signal.Signal0;

class HaxiumDriver extends HaxiumSocket
{
	public var connected:Signal0;
	public var filters(default, null):Array<Filter<Dynamic>>;

	public function new()
	{
		super();
		filters = [new Filter<String>(PACKAGE, "org.shoebox.haxium")];
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
		var action = new SessionAction(CREATE, filters);
		sendSessionAction(action, filters);
	}

	public function listSessions(?filters:Array<Filter<Dynamic>>)
	{
		var action = new SessionAction(LIST, filters);
		sendSessionAction(action, filters);
	}

	function sendSessionAction(action:Sessionaction, 
		?filters:Array<Filter<Dynamic>>)
	{
		var result = Serializer.run(action);
		send(Bytes.ofString(result));
	}
}
