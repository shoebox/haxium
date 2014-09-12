package;

import haxium.protocol.ClientSession;
import haxium.protocol.filter.Filter;
import haxium.protocol.session.SessionSpec;

import haxium.server.Sessions;
import massive.munit.Assert;

class SessionsTest
{
	var sessions:Sessions;

	var specs1:SessionSpec;
	var specs2:SessionSpec;
	var session1:ClientSession;
	var session2:ClientSession;

	public function new()
	{

	}

	@Before
	public function before()
	{
		sessions = new Sessions();

		specs1 = new SessionSpec();
		specs1.add(VERSION, "1.0.1");
		specs1.add(PACKAGE, "com.test.test1");

		specs2 = new SessionSpec();
		specs2.add(VERSION, "1.0.2");
		specs2.add(PACKAGE, "com.test.test");

		session1 = sessions.create(specs1.get(), null);
		session2 = sessions.create(specs2.get(), null);
	}

	@Test
	public function testIds()
	{
		Assert.areNotEqual(session1.id, session2.id);
	}

	@Test
	public function testHooked()
	{
		Assert.isFalse(session1.hooked);
		Assert.isFalse(session2.hooked);
	}

	@Test
	public function testBasic()
	{
		var session1 = sessions.create(specs1.get(), null);
		Assert.isNotNull(session1.id);
	}

	@Test
	public function testSimpleFilter()
	{
		var filters = [
			new Filter(PACKAGE, "com.test.test", EQUAL)
		];
		var result = sessions.get(filters);
		Assert.areEqual(result[0].id, session2.id);
		Assert.areEqual(result.length, 1);

		result = sessions.get([new Filter(PACKAGE, "com.test.osef", EQUAL)]);
		Assert.areEqual(result.length, 0);

		result = sessions.get([new Filter(PACKAGE, "com.test.test1", EQUAL)]);
		Assert.areEqual(result.length, 1);
		Assert.areEqual(result[0].id, session1.id);
	}

	@Test
	public function testCombos()
	{
		var result = sessions.get([
			new Filter(PACKAGE, "com.test.test1", EQUAL),
			new Filter(VERSION, "1.0.1", EQUAL)
		]);

		Assert.areEqual(result.length, 1);
		Assert.areEqual(result[0].id, session1.id);

		result = sessions.get([
			new Filter(PACKAGE, "com.test.test1", EQUAL),
			new Filter(VERSION, "1.0.2", EQUAL)
		]);

		Assert.areEqual(result.length, 0);
	}

	@Test
	public function testHook()
	{
		var filters = [
			new Filter(PACKAGE, "com.test.test1", EQUAL),
			new Filter(VERSION, "1.0.1", EQUAL)
		];

		var hook = sessions.hook(filters);

		Assert.areEqual(hook.sessions.length, 1);
		Assert.isTrue(session1.hooked);
		Assert.isFalse(session2.hooked);
	}
}
