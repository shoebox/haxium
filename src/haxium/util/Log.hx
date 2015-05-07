package haxium.util;

class Log
{
	public static function trace(value:String, color:LogColor)
	{
		var stringColor = switch (color)
		{
			case Black : '\033[30m';
			case Red : '\033[31m';
			case Green : '\033[32m';
			case Yellow : '\033[33m';
			case Blue : '\033[34m';
			case Purple : '\033[35m';
			case Cyan : '\033[36m';
			case White, Default : '\033[37m';
		}

		#if (cpp || neko)
		Sys.println('$stringColor$value \033[m');
		#else
		trace('$value');
		#end
	}
}

enum LogColor
{
	Black;
	Red;
	Green;
	Yellow;
	Blue;
	Purple;
	Cyan;
	White;
	Default;
}
