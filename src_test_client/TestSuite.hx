import massive.munit.TestSuite;

import LoginTest;
import haxium.Device;

/**
 * Auto generated Test Suite for MassiveUnit.
 * Refer to munit command line tool for more information (haxelib run munit)
 */

class TestSuite extends massive.munit.TestSuite
{		
	public static var device:Device;

	public function new()
	{
		super();

		add(LoginTest);
	}
}
