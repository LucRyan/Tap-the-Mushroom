package game.tap.mushroom;

import engine.objects.TouchableObject;
import format.display.MovieClip;
import nme.display.Bitmap;
import nme.display.Sprite;
import nme.events.MouseEvent;
import nme.events.TouchEvent;
import nme.Assets;
import nme.Lib;
import nme.media.Sound;
import engine.sound.SoundSystem;

/**
 * ...
 * @author Yang Wang
 */

class Mushroom extends TouchableObject
{
	
	public function new(?movieClipPath : String) 
	{
		super();
		loadMovieClip((movieClipPath == null) ? "TaptheMushroom:tm.RedMushroomJump" : movieClipPath );
		addListener();
	}

	override public function mouseClick(mouseEvent : MouseEvent) {
		objectClip.visible = false;
		SoundSystem.SOUND_SYSTEM.getInstance().playSoundFx("PokeMushroom", 1);
	}
}