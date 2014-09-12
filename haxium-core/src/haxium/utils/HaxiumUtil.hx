package haxium.utils;

import haxe.crypto.Md5;

class HaxiumUtil
{
	static var SALT = 100;

	public static function ID():String
	{
		var date = Date.now();
		return Md5.encode(date.toString() + SALT++);
	}

	public static function compareVersion(version1:String, version2:String):Int
	{
		var a = version1.split(".");
		var b = version2.split(".");

		var itera = a.iterator();
		var iterb = b.iterator();

		var i:Int;
		var j:Int;

		var sa:String;
		var sb:String;

		while (itera.hasNext() && iterb.hasNext())
		{
			sa = itera.next();
			sb = iterb.next();

			if(sa == "x" || sb == "x")
				return 0;
			
			i = Std.parseInt(sa);
			j = Std.parseInt(sb);
			
			if (i > j)
				return 1;
			else if (i < j)
				return -1;

			if (itera.hasNext() && !iterb.hasNext())
				return 1;
		}

		if (!itera.hasNext() && iterb.hasNext())
    	        return -1;
    	
    	return 0;
	}
}
