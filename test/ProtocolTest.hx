package;

import haxe.io.BytesInput;
import haxe.io.BytesOutput;

import haxe.io.Output;
import haxium.protocol.RemoteProtocol;

import massive.munit.util.Timer;
import massive.munit.Assert;
import massive.munit.async.AsyncFactory;

class ProtocolTest
{
	static var TEST_REQUEST:RemoteRequest<String> = {datas : "toto", action : 100};

	macro public static function getRef(){
		return macro RemoteProtocol.getBytesOf(TEST_REQUEST);
    }

	@Test
	public function testObjectSerialization()
	{
		var bytes = RemoteProtocol.getBytesOf(TEST_REQUEST);
		var result = RemoteProtocol.getFromBytes(bytes);
	
		Assert.areEqual(result.action, TEST_REQUEST.action);
		Assert.areEqual(result.datas, TEST_REQUEST.datas);
	}

	@Test
	public function testOutput()
	{
		var bytes = RemoteProtocol.getBytesOf(TEST_REQUEST);
		var ref = getRef();
		for(i in 0...ref.length)
			Assert.areEqual(bytes.get(i), ref.get(i));
	}
}
