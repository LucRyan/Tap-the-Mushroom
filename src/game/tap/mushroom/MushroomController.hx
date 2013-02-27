package game.tap.mushroom;
import game.tap.mushroom.Mushroom;
import format.display.MovieClip;

/**
 * Control the Msuhrooms 
 * @author Yang Wang
 */

class MushroomController
{	
	public function new() {
		
	}
	
	public function startJump(mushroom : Mushroom) : Void {
		mushroom.objectClip.play();
		mushroom.jumpSound.play(0, 1);
	}
	
	public function stopJump(mushroom : Mushroom) : Void {
		mushroom.objectClip.gotoAndStop(2);
	}

}