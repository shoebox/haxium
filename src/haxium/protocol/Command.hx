package haxium.protocol;

enum Command
{
	Click(stageX:Int, stageY:Int);
	Elements(?list:Array<String>);
	ElementsByType(type:String);
	Element(action:ElementCommand, id:String);
}
