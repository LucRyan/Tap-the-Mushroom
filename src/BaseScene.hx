package ;

import nme.display.Bitmap;
import nme.display.Sprite;
import nme.display.StageAlign;
import nme.display.StageScaleMode;
import nme.events.Event;
import nme.Assets;
import nme.Lib;

/**
 * ...
 * @author Yang Wang
 */

class BaseScene extends Sprite
{

	public function new() 
	{
		super();
		//Add the BaseScene to current Stage.
		addEventListener (Event.ADDED_TO_STAGE, this_onAddedToStage);
	}
	
	//This function will be called when the sprite Added to current Stage.
	private function construct() {}
	
	//This function will be called when the window be resized.
	private function resize() {}
	
	
	// Event Handlers
	
	//On Resize 
	private function stage_onResize (event:Event):Void {
		resize ();
	}
	
	//On added to stage
	private function this_onAddedToStage (event:Event):Void {
		construct ();
	}
	
	
}