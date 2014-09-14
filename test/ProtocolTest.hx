package;

import haxe.io.BytesInput;
import haxe.io.BytesOutput;

import haxe.io.Output;
import haxium.protocol.RemoteProtocol;

import haxium.protocol.session.SessionSpec;
import massive.munit.util.Timer;
import massive.munit.Assert;
import massive.munit.async.AsyncFactory;

class ProtocolTest
{
	static var TEST_REQUEST:RemoteRequest<String> = {datas : "toto", action : 100};

	macro public static function getRef(){
		return macro RemoteProtocol.getBytesOf(TEST_REQUEST);
    }

	@Test public function testObjectSerialization()
	{
		var bytes = RemoteProtocol.getBytesOf(TEST_REQUEST);
		var result = RemoteProtocol.getFromBytes(bytes);
	
		Assert.areEqual(result.action, TEST_REQUEST.action);
		Assert.areEqual(result.datas, TEST_REQUEST.datas);
	}

	@Test public function testOutput()
	{
		var bytes = RemoteProtocol.getBytesOf(TEST_REQUEST);
		var ref = getRef();
		for(i in 0...ref.length)
			Assert.areEqual(bytes.get(i), ref.get(i));
	}

	@Test public function testRequest()
	{
		var specs = new SessionSpec();
		specs.add(VERSION, "1.0.1");
		specs.add(PACKAGE, "org.shoebox.test");

		var request1 = {action:101, datas:"Test Datas"};
		var request2 = {action:102, datas:specs};

		var bytes1 = RemoteProtocol.serializeRequest(request1);
		var bytes2 = RemoteProtocol.serializeRequest(request2);

		var result1 = RemoteProtocol.getFromBytes(bytes1);
		var result2 = RemoteProtocol.getFromBytes(bytes2);

		Assert.areEqual(request1.action, result1.action);

		var specsBF = request2.datas.get();
		var specsAF = result2.datas.get();
		
		Assert.areEqual(specsBF[0].type, specsAF[0].type);
		Assert.areEqual(specsBF[1].type, specsAF[1].type);

		Assert.areEqual(specsBF[0].value, specsAF[0].value);
		Assert.areEqual(specsBF[1].value, specsAF[1].value);
	}
}
