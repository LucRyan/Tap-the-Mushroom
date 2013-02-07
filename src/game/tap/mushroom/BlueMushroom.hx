package game.tap.mushroom;
import format.display.MovieClip;
import nme.Assets;
import nme.display.Sprite;
import engine.objects.TouchableObject;
import nme.events.MouseEvent;

/**
 * ...
 * @author Yang Wang
 */

class BlueMushroom extends Mushroom, implements IMushroom
{

	public function new() 
	{
		super();
		loadMovieClip("TaptheMushroom:tm.BlueMushroomJump");
		addListener();
		setObjectClip(objectClip);
		loadSound();
	}
	
	public var mushClip : MovieClip;
	public function setObjectClip( movieClip : MovieClip ) {
		mushClip = movieClip;
	}
	
	public function startJump() {
		objectClip.play();
		jumpSound.play(0, 1);
	}
	public function stopJump() {
		objectClip.gotoAndStop(2);
	}
}