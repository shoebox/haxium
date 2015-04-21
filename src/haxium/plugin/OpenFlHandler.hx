package haxium.plugin;

import haxium.plugin.IHandler.HandlerResponse;
import haxium.protocol.Command;
import haxium.protocol.ElementCommand;

#if openfl
import openfl.Lib;
import openfl.display.DisplayObject;
import openfl.display.DisplayObjectContainer;
import openfl.events.MouseEvent;
import openfl.geom.Point;
#end

class OpenFlHander implements IHandler
{
	public function new()
	{
		
	}

	public function onMessage(message:Command):HandlerResponse
	{
		var result:HandlerResponse = null;
		result = switch (message)
		{
			case Command.Click(stageX, stageY) : click(stageX, stageY);
			case Command.Element(action, id) : elementCommand(action, id);
			case Command.Elements(list) : elementsList();
			case Command.ElementsByType(name) : elementsList(name);
			default : null;
		}
		return result;
	}

	function click(stageX:Int, stageY:Int):HandlerResponse
	{
		var event:MouseEvent = new MouseEvent(MouseEvent.CLICK);
		event.stageX = stageX;
		event.stageY = stageY;
		
		var stage = openfl.Lib.current;
		var point = new Point(stageX, stageY);
		var childs = stage.getObjectsUnderPoint(point);
		for (child in childs)
			child.dispatchEvent(event);

		event.target = stage;

		var response:HandlerResponse = 
		{
			handled : true,
			command : null
		}
		return response;
	}

	function elementsList(?name:String):HandlerResponse
	{
		var result = childs(Lib.current.stage, [], name);
		var response:HandlerResponse = 
		{
			handled : true,
			command : Command.Elements(result)
		}

		return response;
	}

	function childs(container:DisplayObjectContainer, result:Array<String>,
		?type:String)
	{
		var count = container.numChildren;
		var child:DisplayObject;
		var childTypeName:String;
		var i = 0;
		while (i < count)
		{
			child = container.getChildAt(i);
			childTypeName = Type.getClassName(Type.getClass(child));
			if (type == null || childTypeName == type)
			{
				result.push(child.name);
			}
			
			if (Std.is(child, DisplayObjectContainer))
			{
				result = childs(cast child, result, type);
			}
			i ++;
		}

		return result;
	}

	function elementCommand(action:ElementCommand, id:String):HandlerResponse
	{
		var handled:Bool = false;
		var result:Command = null;

		#if openfl
		var target = findChild(id);
		if (target != null || id == null)
		{
			switch (action)	
			{
				case GetBounds(value) : 
					if (target != null)
					{
						var refBounds = target.getBounds(Lib.current.stage);
						var resultBounds:ElementBounds = 
						{
							position : 
							{
								x : refBounds.x,
								y : refBounds.y,
							},
							width : refBounds.width,
							height : refBounds.height
						};

						result = Element(GetBounds(resultBounds), id);
					}
					handled = true;

				default:
			}
		}
		#end

		var response:HandlerResponse = 
		{
			handled : handled,
			command : result
		}

		return response;
	}

	#if openfl
	function findChild(?id:String):DisplayObject
	{
		if (id == null) return null;
		var stage = openfl.Lib.current;
		var result = getChild(stage, id);
		return result; 
	}

	function getChild(ref:DisplayObjectContainer, id:String):DisplayObject
	{
		var i = 0;
		var l = ref.numChildren;
		var result:DisplayObject = null;
		var subChild:DisplayObject = null;
		while (i < l)
		{	
			var subChild = ref.getChildAt(i);
			if (subChild.name == id)
			{
				result = subChild;
				break;
			}

			if (Std.is(subChild, DisplayObjectContainer))
				result = getChild(cast(subChild, DisplayObjectContainer), id);

			i++;
		}	

		return result;
	}

	#end

	function getStageChild(id:String)
	{

	}
}
