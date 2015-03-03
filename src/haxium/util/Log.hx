package haxium.util;

class Log
{
	public static function trace(test:String, color:LogColor)
	{
		var stringColor = switch (color)
		{
			case BgRed : '\033[41m';
			case Blue : '\033[35m';
			case Cyan : '\033[36m';
			case Default : '\033[m';
			case Green : '\033[42m';
			case Red : '\033[31m';
		}

		Sys.println('$stringColor$test \033[m');
	}
}

enum LogColor
{
	BgRed;
	Cyan;
	Blue;
	Default;
	Green;
	Red;
}
