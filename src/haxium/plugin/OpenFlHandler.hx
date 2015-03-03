package haxium.plugin;

import haxium.plugin.IHandler.HandlerResponse;
import haxium.protocol.Command;
import haxium.protocol.ElementCommand;

#if openfl
import openfl.Lib;
import openfl.display.DisplayObject;
import openfl.display.DisplayObjectContainer;
#end

class OpenFlHander implements IHandler
{
	public function new()
	{

	}

	public function onMessage(message:Command):HandlerResponse
	{
		trace("onMessage ::: " + message);
		var result:HandlerResponse = null;
		result = switch (message)
		{
			case Element(action, id) : elementCommand(action, id);
			default : null;
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
