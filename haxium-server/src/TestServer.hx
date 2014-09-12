package;

import haxium.server.Server;
import sys.net.Host;

class TestServer 
{
	static public function main()
	{
		var server = new Server();
		server.connect("localhost", 1234);
	}
}
