package;

import haxium.protocol.RemoteProtocol;

import haxium.driver.Driver;
import haxium.protocol.session.SessionSpec;

class TestDriver
{
	static var driver:Driver;

	static public function main()
	{
		driver = new Driver();
		driver.opened.addOnce(connectionOpened);
		driver.connect("localhost", 1234);
		

		while (true)
		{
			var bytes = driver.socket.input.readAll();
			trace(RemoteProtocol.getFromBytes(bytes));
		}
	}

	static function connectionOpened()
	{
		var specs = new SessionSpec();
		specs.add(PACKAGE, "org.shoebox.haxium");
		specs.add(VERSION, "1.0.0");

		driver.create(specs);
	}
}
