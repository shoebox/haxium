package haxium.protocol;

import haxe.crypto.Md5;
import haxe.io.Bytes;
import haxe.io.BytesInput;
import haxe.io.BytesOutput;
import haxe.io.Input;
import haxe.io.Output;
import haxe.Serializer;
import haxe.Unserializer;

import haxium.protocol.ClientSession;
import haxium.protocol.Hook;
import haxium.protocol.filter.Filter;
import haxium.protocol.Session;
import haxium.protocol.session.SessionSpec;

#if server
typedef ASocket = sys.net.Socket;
#else
typedef ASocket = haxium.utils.HaxiumSocket;
#end

class RemoteProtocol
{
	public static inline var CREATE:Int = 0x100;
	public static inline var CREATED:Int = 0x101;
	public static inline var HOOK:Int = 0x110;

	public function new()
	{
	}

	#if driver
	public static function create(socket:ASocket, specs:DSessionSpecs)
	{
		output(CREATE, socket, specs);
	}
	#end

	public static function created(socket:ASocket, session:ClientSession)
	{
		output(CREATED, socket, session);
	}

	public static function hook(socket:ASocket, hook:Hook):Void
	{
		output(HOOK, socket, hook);
	}

	public static function createRequest(action:Int, 
		datas:Dynamic):RemoteRequest<Dynamic>
	{
		var request = {action:action, datas:datas};
		return request;
	}

	public static function serializeRequest(request:RemoteRequest<Dynamic>):Bytes
	{
		var bytes = getBytesOf(request);
		return bytes;
	}

	public static function readRequest(bytes:Bytes):RemoteRequest<Dynamic>
	{
		var request = getFromBytes(bytes);
		return request;
	}

	public static function output(action:Int, socket:ASocket, datas:Dynamic)
	{
		var request = {action:action, datas:datas};
		var bytes = serializeRequest(request);

		#if server
		socket.output.writeBytes(bytes, 0, bytes.length);
		#else
		socket.send(bytes);
		#end
	}

	public static function getFromInput<T>(input:Input):RemoteRequest<T>
	{
		var length = Std.int(input.readFloat());
		
		var stringBytes = input.readString(length);
		var raw = stringBytes.toString();
		
		var result = Unserializer.run(raw);
		result.length = length;
		return result;
	}
 
	public static function getFromBytes<T>(bytes:Bytes):RemoteRequest<T>
	{
		var length = Std.int(bytes.getFloat(0));
		if (length > bytes.length)
			return null;

		var stringBytes = bytes.sub(8, length);
		var raw = stringBytes.toString();
		
		var result = Unserializer.run(raw);
		result.length = length + 8;
		return result;
	}	

	static public function getBytesOf<T>(value:RemoteRequest<T>):Bytes
	{
		var raw = Serializer.run(value);
		var bytes = Bytes.ofString(raw);

		var result = Bytes.alloc(8 + bytes.length);
		result.setFloat(0, bytes.length);

		for (i in 0...bytes.length)
			result.set(8 + i, bytes.get(i));

		return result;
	}
}

typedef RemoteRequest<T>=
{
	public var datas:T;
	public var action:Int;
	@:optional public var length:Null<Int>;
}
