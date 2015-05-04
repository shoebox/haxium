package;

import haxium.protocol.element.Element;
import massive.munit.util.Timer;
import massive.munit.Assert;
import massive.munit.async.AsyncFactory;

import haxium.protocol.command.Command;

class LibraryTest
{
	var movieItems:Array<Element>;

	public function new(){}
	
	@BeforeClass public function beforeClass(){}
	@AfterClass public function afterClass(){}
	@Before public function setup()
	{
		
	}
	
	@After public function tearDown()
	{

	}


	@Test public function test1List()
	{
		Sys.sleep(10);
		var elements = Main.currentDevice.elements.get();
		// for (element in Main.currentDevice.elements.get())
			// trace(element);
		
		// movieItems = Main.currentDevice.elements.get(By.ElementType("store.companion.item.carousel.CarouselItemMovieMobile"));
		// trace(movieItems);
		// trace(movieItems[0].getProperty("entitlementDetails").getProperty("title").getProperty("value"));
		// trace(movieItems[1].getProperty("entitlementDetails").getProperty("title").getProperty("value"));
		// Assert.areEqual(2, movieItems.length);

		// trace(movieItems[0].getProperty("entitlementDetails").getProperty("title").getProperty("value"));
	}

	@Test public function test2Button()
	{
		// var overlayButton = Main.currentDevice.elements.get(By.ElementType("store.companion.item.OverlayButtonItemMobile"));
		// trace("overlayButton ::: " + overlayButton);

		// var details = Main.currentDevice.elements.get(By.ElementType("store.companion.item.movie.MovieDetailsMobile"));
		// trace("details ::: ");
		// for (entry in details)
		// {
		// 	trace(entry);
		// 	trace(entry.getProperty("metas"));
		// }
	}
}
