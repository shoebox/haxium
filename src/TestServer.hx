package;

import haxium.server.HaxiumServer;
import sys.net.Host;

class TestServer 
{
	static public function main()
	{
		trace("main");
		var server = new HaxiumServer();
		server.run("localhost", 1234);
	}
}
