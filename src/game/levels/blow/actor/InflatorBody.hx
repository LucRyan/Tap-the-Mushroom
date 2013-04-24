package game.levels.blow.actor;
import engine.objects.SceneObject;
import nme.Lib;

/**
 * ...
 * @author Yang Wang
 */
class InflatorBody extends SceneObject
{

	public function new(?movieClipPath : String) 
	{
		super();
		loadMovieClip((movieClipPath == null) ? "TaptheMushroom:tm.InflatorBody" : movieClipPath );
	}
}