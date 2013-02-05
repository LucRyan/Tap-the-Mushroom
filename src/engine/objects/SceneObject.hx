package engine.objects;

import format.display.MovieClip;
import nme.display.Bitmap;
import nme.display.Sprite;
import nme.Assets;

/**
 * The Basic object with Bitmap or MovieClip
 * @author Yang Wang
 */

class SceneObject extends Sprite
{

	public function new() 
	{
		super();	
	}
	
	var objectBitmap : Bitmap; // The Sprite's Bitmap
	var objectClip : MovieClip; // The Sprite's MovieClip
	
	/**
	 * Load MovieClip 
	 *
	 * @param	movieClipPath is the path contains movieclip
	 */ 
	private function loadMovieClip(movieClipPath : String) : Void {
		objectClip = Assets.getMovieClip (movieClipPath);
	}
	
	/**
	 * Load Bitmap
	 * 
	 * @param	bitmapPath is the path contains bitmap
	 */
	private function loadBitmap (bitmapPath : String) : Void {
		objectBitmap = new Bitmap (Assets.getBitmapData (bitmapPath));
	}
	
}