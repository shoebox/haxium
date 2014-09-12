package;

import haxium.utils.HaxiumUtil;
import massive.munit.Assert;

class UtilsTest
{
	public static inline var VERSION234 = "2.3.4";
	public static inline var VERSION230 = "2.3.0";
	public static inline var VERSION23X = "2.3.x";
	public static inline var VERSION24X = "2.4.x";
	public static inline var VERSION23 = "2.3";

	@Test public function testID()
	{
		var id1 = HaxiumUtil.ID();
		var id2 = HaxiumUtil.ID();
		Assert.areNotEqual(id1, id2);
	}

	@Test public function compareVersion()
	{
		Assert.areEqual(HaxiumUtil.compareVersion(VERSION234, VERSION234) , 0);
		Assert.areEqual(HaxiumUtil.compareVersion(VERSION230, VERSION234) , -1);
		Assert.areEqual(HaxiumUtil.compareVersion(VERSION234, VERSION230) , 1);
	}

	@Test public function compareVersionX()
	{
		Assert.areEqual(HaxiumUtil.compareVersion(VERSION23X, VERSION234) , 0);	
		Assert.areEqual(HaxiumUtil.compareVersion(VERSION23X, VERSION230) , 0);	
		Assert.areEqual(HaxiumUtil.compareVersion(VERSION23X, VERSION24X) , -1);	
		Assert.areEqual(HaxiumUtil.compareVersion(VERSION24X, VERSION23X) , 1);	
	}
}
