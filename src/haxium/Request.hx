package haxium;

class Request
{
	public var method(default, default):String = "GET";
	public var host(default, default):String;
	public var request(default, default):String;
	public var headers(default, default):Map<String, Dynamic>;

	public function new(host:String, request:String)
	{
		this.host = host;
		this.request = request;
	}

	public function get():String
	{
		var b = new StringBuf();
		b.add(method);
		b.add(" ");
		b.add(request);
		b.add(" HTTP/1.1\r\nHost: "+host+"\r\n");
		b.add("\r\n");
		
		return b.toString();
	}
}
