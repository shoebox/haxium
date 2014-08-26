package;

import haxium.client.Client;
import haxium.protocol.filter.Filter;

//import haxium.client.HaxiumClient;
//import haxium.protocol.filter.Filter;

class TestClient
{
	static public function main()
	{
		trace("main");
		var client = new Client();
		client.connect("localhost", 1234);

		var filters = [
			new Filter<String>(PACKAGE, "org.shoebox.haxium", EQUAL),
			new Filter<String>(VERSION, "1.0.0", EQUAL)
		];

		var session = client.get(filters);



		while(true){}

		/*
		var filters = [new Filter<String>(PACKAGE, 
			"org.shoebox.haxium", EQUAL)];

		var client = new HaxiumClient();
		client.connect("localhost", 1234);

		var session = client.session(filters);

		trace("session ::: " + session);

		session.elements.byId("toto");
		*/
	}
}
