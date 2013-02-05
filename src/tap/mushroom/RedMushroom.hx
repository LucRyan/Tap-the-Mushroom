package tap.mushroom;
import format.display.MovieClip;
import nme.Assets;
import nme.display.Sprite;


/**
 * ...
 * @author Yang Wang
 */

class RedMushroom extends Sprite, implements Mushroom
{

	public function new() 
	{
		super();
		loadMushroom("TaptheMushroom:tm.RedMushroomJump");
	}
	
	public var mushClip : MovieClip;
	
	public function loadMushroom(mushroomPath : String) : Void {
		mushClip = Assets.getMovieClip (mushroomPath);
	}
}