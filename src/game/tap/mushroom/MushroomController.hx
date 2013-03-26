package game.tap.mushroom;
import game.tap.mushroom.Mushroom;
import format.display.MovieClip;
import engine.sound.SoundSystem;

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
		SoundSystem.SOUND_SYSTEM.getInstance().playSoundFx("MushroomJump", 1);
	}
	
	public function stopJump(mushroom : Mushroom) : Void {
		mushroom.objectClip.gotoAndStop(2);
	}

}