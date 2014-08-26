package;

import haxium.server.Server;
import sys.net.Host;

class TestServer 
{
	static public function main()
	{
		trace("main");
		var server = new Server();
		server.run("localhost", 1234);
	}
}
