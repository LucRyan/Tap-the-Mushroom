package game.levels.blow.actor;
import nme.Lib;

/**
 * ...
 * @author Yang Wang
 */
class ActorController
{

	public function new() 
	{
		
	}
	
	public function resizeMovieClip(object : Dynamic, originWidth : Int, originHeight : Int, sizeLvl : Float, positionX : Float, positionY : Float) :Void { 
		//Size
		var scaleWidth = Lib.current.stage.stageWidth / 30 * sizeLvl; // margin is width/10, and the scale offset is width/40.
		var scaleHeight = scaleWidth / originWidth * originHeight; // Scale the height with Image ratio.
		object.height = scaleHeight;
		object.width = scaleWidth;
		object.alpha = 1.0;
		//Position
		object.x = Std.int(Lib.current.stage.stageWidth  / 800 * positionX);
		object.y = Std.int(Lib.current.stage.stageHeight  / 480  * positionY);
	}
}