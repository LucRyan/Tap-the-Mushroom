package engine.scene;

import nme.display.Bitmap;
import nme.display.Sprite;
import nme.display.StageAlign;
import nme.display.StageScaleMode;
import nme.events.Event;
import nme.Assets;
import nme.Lib;


/**
 * This Class build as the fundemental scene for the Game.
 * It will load the background image, two basic button and one star display.
 * 
 * @author Yang Wang
 */

class BaseScene extends Sprite
{
	private var background:Bitmap;
	
	public function new() 
	{
		super();
		//Add the BaseScene to current Stage.
		addEventListener (Event.ADDED_TO_STAGE, this_onAddedToStage);
	}
	
	//This function will be called when the sprite Added to current Stage.
	private function construct() : Void {}
	
	/**
	 * This function will be called when the window be resized.
	 */
	private function resize() : Void {
		resizeBackground();	// Resize the backgroun image correspond with screen size.
	}
	
	/**
	 * This function will resize the background when the screen been resized.
	 */
	private function resizeBackground () : Void {
		if(background != null){
			//Size
			background.height = stage.stageHeight + 20;
			background.width = stage.stageWidth + 20;
			background.alpha = 1.0;
			//Position
			background.x = (stage.stageWidth - background.width) / 2;
			background.y = (stage.stageHeight - background.height) / 2;
		}else {
			throw("No Background Image Loaded.");
		}
	}
	
	/**
	 * Load Background image from filepath
	 * 
	 * @param	backgroundPath is the file path of background image.
	 */
	private function loadBackground (backgroundPath : String) : Void {
		background = new Bitmap (Assets.getBitmapData (backgroundPath));
	}
	
	
	/********************************/
	/* 		 Event Handlers			*/
	/********************************/
	//On Resize 
	private function stage_onResize (event:Event):Void {
		resize ();
	}
	
	//On added to stage
	private function this_onAddedToStage (event:Event):Void {
		construct ();
	}
	
	
}