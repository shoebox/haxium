package;


import openfl.display.Sprite;
import sys.net.Host;
import sys.net.Socket;


class Main extends Sprite {
	
	
	public function new () {
		
		super ();
		
		trace("constructor");
		var socket = new Socket();
		var port = 8080;
		var host = new Host("192.168.1.101");
		while (true)
		{
			trace("trying");
            try {
               trace("connect");
                socket.connect(host, port);
                trace("Connected to debugging server at " + host + ":" + port + ".");
                return;
            }
            catch (e : Dynamic) {
                trace("Failed to connect to debugging server at " +
                            host + ":" + port + " : " + e);
            }
            Sys.println("Trying again in 3 seconds.");
            Sys.sleep(3);
        }

	}
	
	
}
