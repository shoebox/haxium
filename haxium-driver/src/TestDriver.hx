package;

import haxium.driver.Driver;

class TestDriver
{
	static public function main()
	{
		var driver = new Driver();
		driver.connect("localhost", 1234);
		driver.opened.addOnce(connOpened);
	}

	static function connOpened()
	{
		trace("connOpened");
	}
}
