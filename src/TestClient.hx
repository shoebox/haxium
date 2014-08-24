package;

import haxium.client.HaxiumClient;
import haxium.protocol.filter.Filter;

class TestClient
{
	static public function main()
	{
		var filters = [new Filter<String>(PACKAGE, 
			"org.shoebox.haxium", EQUAL)];

		var client = new HaxiumClient();
		client.connect("localhost", 1234);
		trace("session ::: " + client.session(filters));

		trace(client.sessions([new Filter<String>(PACKAGE, "org.shoebox.haxium", EQUAL)]));
		trace(client.sessions([new Filter<String>(PACKAGE, "org.shoebox.haxium2", EQUAL)]));
	}
}
