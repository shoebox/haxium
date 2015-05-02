package haxium.protocol;

enum Command
{
	DeviceAction(action:DeviceCommand);
	SessionAction(action:SessionCommand);
	Element(id:String);
	ElementCommand(id:String, action:ElementCommand);
	Elements(?by:By);
	ElementsResult(list:Array<String>);
}
