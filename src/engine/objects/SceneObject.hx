package engine.objects;

import format.display.MovieClip;
import nme.display.Bitmap;
import nme.display.Sprite;
import nme.Assets;
import nme.Lib;

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
	
	public var objectBitmap : Bitmap; // The Sprite's Bitmap
	public var objectClip : MovieClip; // The Sprite's MovieClip
	
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
	
	//Resize the Object
	//public function resizeObject() : Void { }
	public function resizeMovieClip(object : Dynamic, originWidth : Int, originHeight : Int, sizeLvl : Int, positionX : Float, positionY : Float) :Void { 
		//Size
		var scaleWidth = Lib.current.stage.stageWidth / sizeLvl; // margin is width/10, and the scale offset is width/40.
		var scaleHeight = scaleWidth / originWidth * originHeight; // Scale the height with Image ratio.
		object.height = scaleHeight;
		object.width = scaleWidth;
		object.alpha = 1.0;
		//Position
		object.x = Std.int(Lib.current.stage.stageWidth * positionX);
		object.y = Std.int(Lib.current.stage.stageHeight * positionY);
	}
	
}