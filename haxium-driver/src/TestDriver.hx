package;

import haxium.driver.Driver;
import haxium.protocol.session.SessionSpec;

class TestDriver
{
	static var driver:Driver;

	static public function main()
	{
		trace("main");
		driver = new Driver();
		driver.opened.addOnce(connectionOpened);
		driver.connect("localhost", 1234);
		

		while(true){}
	}

	static function connectionOpened()
	{
		trace("connectionOpened");
		var specs = new SessionSpec();
		specs.add(PACKAGE, "org.shoebox.haxium");
		specs.add(VERSION, "1.0.0");

		driver.create(specs);
	}
}
