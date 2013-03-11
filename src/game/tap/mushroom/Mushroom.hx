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

/**
 * ...
 * @author Yang Wang
 */

class Mushroom extends TouchableObject
{
	//TODO: Should I put sound here?? I think it is the time to Build SOUND SYSTEM!!!!
	public var jumpSound : Sound;
	var pokeSound : Sound;
	
	public function new(?movieClipPath : String, ?jumpSoundPath : String, ?pokeSoundPath : String) 
	{
		super();
		loadMovieClip((movieClipPath == null) ? "TaptheMushroom:tm.RedMushroomJump" : movieClipPath );
		loadSound(jumpSoundPath, pokeSoundPath);
		addListener();
	}

	override public function mouseClick(mouseEvent : MouseEvent) {
		objectClip.visible = false;
		pokeSound.play(0, 1);
	}
	
	override public function fingerTap(touchEvent : TouchEvent){
		objectClip.visible = false;
		pokeSound.play(0, 1);
	}
	
	private function loadSound(?jumpSoundPath : String, ?pokeSoundPath : String){
		jumpSound = Assets.getSound ((jumpSoundPath == null) ? "sound/MushroomJump.mp3" : jumpSoundPath);
		pokeSound = Assets.getSound ((pokeSoundPath == null) ? "sound/PokeMushroom.mp3" : pokeSoundPath);
	}	
}