package haxium.protocol.session;

typedef DSessionSpecEntry = SessionSpecEntry<Dynamic>;
typedef DSessionSpecs = Array<DSessionSpecEntry>;

class SessionSpec
{
	public var specs(default, null):DSessionSpecs;

	public function new()
	{	
		specs = [];
	}	

	public function add<T>(type:SessionSpecType, value:T)
	{
		var spec = new SessionSpecEntry(type, value);
		specs.push(spec);
	}

	public function get():DSessionSpecs
	{
		return specs;
	}
}

class SessionSpecEntry<T>
{
	public var type(default, null):SessionSpecType;
	public var value(default, null):T;

	public function new(type:SessionSpecType, value:T)
	{
		this.type = type;
		this.value = value;
	}
}

enum SessionSpecType
{
	VERSION;
	PACKAGE;
}
