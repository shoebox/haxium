package;

import haxium.protocol.Element;
import massive.munit.util.Timer;
import massive.munit.Assert;
import massive.munit.async.AsyncFactory;

import haxium.protocol.By;

class LoginTest 
{
	private var timer:Timer;
	
	var elementInput1:Element;
	var elementInput2:Element;
	var feedback:Element;
	var button:Element;

	public function new(){}
	
	@BeforeClass public function beforeClass(){}
	@AfterClass public function afterClass(){}
	@Before public function setup()
	{
		
	}
	
	@After public function tearDown()
	{

	}


	@Test public function test1GetFields()
	{
		Sys.sleep(20);
		var filter = By.ElementType("mui.input.TextInput");
		var inputs:Array<Element> = Main.currentDevice.elements.get(filter);
		Assert.areEqual(inputs.length, 2);

		elementInput1 = inputs[0];
		elementInput2 = inputs[1];
		
		Assert.isNotNull(elementInput1);
		Assert.isNotNull(elementInput2);

		filter = By.ElementType("store.companion.account.login.form.FormViewFeedback");
		inputs = Main.currentDevice.elements.get(filter);
		Assert.areEqual(inputs.length, 1);
		feedback = inputs[0];

		filter = By.ElementType("store.companion.view.component.LabelledButton");
		inputs = Main.currentDevice.elements.get(filter);
		button = inputs[0];
		Assert.isNotNull(button);
	}
	
	@Test public function test2Empty()
	{
		elementInput1.setProperty("data", "");
		elementInput2.setProperty("data", "");
		button.click();
	
		var errorText = feedback.getProperty("errorText");			
		var both = "- this field is required\n- this field is required";
		Assert.areEqual(both, errorText);
	}

	@Test public function test3Empty()
	{
		elementInput1.setProperty("data", "aaaaa@aaaaa.com");
		elementInput2.setProperty("data", "");
		button.click();
	
		var errorText = feedback.getProperty("errorText");			
		var both = "this field is required";
		Assert.areEqual(both, errorText);
	}

	@Test public function test4InvalidEmail()
	{
		elementInput1.setProperty("data", "aaaaaaaaaa.com");
		elementInput2.setProperty("data", "12345qq");
		button.click();
	
		var errorText = feedback.getProperty("errorText");			
		var invalidEmail = "Please enter a valid email address";
		Assert.areEqual(invalidEmail, errorText);
	}

	@Test public function test5InvalidPassword()
	{
		elementInput1.setProperty("data", "aaaaa@aaaaa.com");
		elementInput2.setProperty("data", "12345");
		button.click();
	
		var errorText = feedback.getProperty("errorText");			
		var invalidPassword = "The password must be at least 6 characters long.";
		Assert.areEqual(invalidPassword, errorText);
	}

	@Test public function test6InvalidCombo()
	{
		elementInput1.setProperty("data", "aaaaa@aaaaa.com");
		elementInput2.setProperty("data", "123456");
		button.click();
		
		Sys.sleep(10);

		var errorText = feedback.getProperty("errorText");			
		var invalidPassword = "Invalid credentials";
		Assert.areEqual(invalidPassword, errorText);
	}
	
	@Test public function test7Help()
	{
		var filter:By;
		var elems:Array<Element>;

		filter = By.ElementType("app.view.common.TouchDataButton");
		elems = Main.currentDevice.elements.get(filter);
		elems[0].click();

		Sys.sleep(1);

		filter = By.ElementType("store.companion.account.login.help.LoginHelpViewMobile");
		elems = Main.currentDevice.elements.get(filter);
		Assert.areEqual(1, elems.length);

		filter = By.ElementType("store.companion.view.component.PanelLabelledButton");
		elems = Main.currentDevice.elements.get(filter);
		Sys.sleep(1);
		elems[0].click();

		filter = By.ElementType("store.companion.account.login.help.LoginHelpViewMobile");
		elems = Main.currentDevice.elements.get(filter);
		Assert.areEqual(1, elems.length);
		Assert.areEqual(false, elems[0].getProperty("visible"));
	}

	@Test public function test8Login()
	{
		elementInput1.setProperty("data", "massivisionautomation@gmail.com");
		elementInput2.setProperty("data", "osefosef");
		button.click();
	}
}
