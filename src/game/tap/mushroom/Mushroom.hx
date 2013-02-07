package game.tap.mushroom;

import engine.objects.TouchableObject;
import format.display.MovieClip;
import nme.display.Bitmap;
import nme.display.Sprite;
import nme.events.MouseEvent;
import nme.Assets;
import nme.Lib;
import nme.media.Sound;

/**
 * ...
 * @author Yang Wang
 */

class Mushroom extends TouchableObject
{
	var jumpSound : Sound;
	var pokeSound : Sound;
	
	public function new() 
	{
		super();
	}
	
	override private function mouseClick(mouseEvent : MouseEvent) {
		objectClip.visible = false;
		pokeSound.play(0, 1);
	}
	
	private function loadSound(){
		jumpSound = Assets.getSound ("sound/MushroomJump.mp3");
		pokeSound = Assets.getSound ("sound/PokeMushroom.mp3");
	}	
}