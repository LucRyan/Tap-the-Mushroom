package game.levels.blow.actor;

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

class InflatorHandle extends TouchableObject
{
	
	public function new(?movieClipPath : String) 
	{
		super();
		loadMovieClip((movieClipPath == null) ? "TaptheMushroom:tm.InflatorHandle" : movieClipPath );
		addListener();
	}
}