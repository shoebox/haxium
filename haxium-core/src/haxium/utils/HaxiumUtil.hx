package haxium.utils;

import haxe.crypto.Md5;

class HaxiumUtil
{
	static var SALT = 100;

	public static inline var RESET   = 0;
	public static inline var BLACK   = 30;
	public static inline var RED     = 31;
	public static inline var GREEN   = 32;
	public static inline var YELLOW  = 33;
	public static inline var BLUE    = 34;
	public static inline var MAGENTA = 35;
	public static inline var CYAN    = 36;
	public static inline var WHITE   = 37;

	public static function ID(?pepper:String = ""):String
	{
		var date = Date.now();
		return Md5.encode(date.toString() + SALT++ + pepper);
	}

	public static function println(data:String, ?col:Int = BLUE)
	{
		#if flash
		trace(data);
		#else
		Sys.println('\033[${col}m$data\033[0m');
		#end
	}

	public static function print(data:String, ?col:Int = BLUE)
	{
		#if flash
		trace(data);
		#else
		Sys.print('\033[${col}m$data\033[0m');
		#end
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
