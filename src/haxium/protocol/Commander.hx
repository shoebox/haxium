package haxium.protocol;

import haxe.io.Bytes;
import haxe.io.Input;
import haxe.io.Output;
import haxe.Serializer;
import haxe.Unserializer;
import haxium.util.Log;
import sys.net.Socket;
import haxium.protocol.command.Command;

class Commander
{
    public static function writeCommand(output:Output, command:Command)
    {
        writeDynamic(output, command);
    }

	public static function readCommand(input:Input):Command
	{
        var raw = readDynamic(input);
        var result:Command = null;
		try
		{
			result = raw;
		}
		catch (error:Dynamic)
		{
			trace("Expected command, but got " + raw + ": " + error);
		}

        return result;
	}

    public static function writeDynamic(output:Output, value:Dynamic)
    {
        var string = Serializer.run(value);

        var length = string.length;
        var lengthRaw:Bytes = Bytes.alloc(8);

        for (i in 0 ... 8)
        {
            lengthRaw.set(7 - i, (length % 10) + 48);
            length = Std.int(length / 10);
        }
        output.write(lengthRaw);
        output.writeString(string);
    }

    private static function readDynamic(input:haxe.io.Input):Dynamic
    {
        if (input == null) return null;
        var lengthRaw = input.read(8);
        var length = 0;
        for (i in 0 ... 8)
        {
            length *= 10;
            length += lengthRaw.get(i) - 48; // 48 is ASCII '0'
        }
        
        if (length > (100 * 1024))
            throw "Read bad message length: " + length + ".";
        
        var raw = input.read(length).toString();
        var result = Unserializer.run(raw);
        return result;
    }
}
