package game.tap.mushroom;

import format.display.MovieClip;
import nme.display.Bitmap;
import nme.display.Sprite;
import nme.events.Event;
import nme.Assets;
import nme.Lib;

/**
 * ...
 * @author Yang Wang
 */

interface Mushroom 
{
	var mushClip : MovieClip;
	
	function loadMushroom(mushroomPath : String) : Void ;	
}