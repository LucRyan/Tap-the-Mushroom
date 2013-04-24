package game.levels.shake.utils;
import engine.objects.SceneObject;

/**
 * ...
 * @author Yang Wang
 */
class BlinkBanner extends SceneObject
{

	public function new() 
	{
		super();
		loadMovieClip("TaptheMushroom:tm.Blink");
	}
	
	public function resizeBanner(object:Dynamic, originWidth:Int, originHeight:Int, sizeLvl:Int, positionX:Float, positionY:Float):Void 
	{
		super.resizeMovieClip(object, originWidth, originHeight, sizeLvl, positionX, positionY);
	}
}