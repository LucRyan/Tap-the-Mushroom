package;


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

class TapThemAll extends BaseScene
{
	
	private var background:Bitmap;
	private var mushroom:Bitmap;
	
	public function new () {	
		super();
	}
	
	
	private function loadBackground (backgroundPath : String) {
		background = new Bitmap (Assets.getBitmapData (backgroundPath));
	}
	
	private function loadMushroom (mushroomPath : String) {
		mushroom = new Bitmap (Assets.getBitmapData (mushroomPath));
	}
	
	private function resizeBackground () : Void {
		//Size
		background.height = stage.stageHeight;
		background.width = stage.stageWidth;
		background.alpha = 1.0;
		//Position
		background.x = (stage.stageWidth - background.width) / 2;
		background.y = (stage.stageHeight - background.height) / 2;
	}
	
	private function resizeMushroom () : Void {
		//Size
		var scaleWidth = ((stage.stageWidth  - 80) / 8  - 20 );
		var scaleHeight = scaleWidth / 188 * 155;
		mushroom.height = scaleHeight;
		mushroom.width = scaleWidth;
		mushroom.alpha = 1.0;
		//Position
		mushroom.x = (stage.stageWidth - mushroom.width) / 2;
		mushroom.y = (stage.stageHeight - mushroom.height) / 2;
	}
	
	override private function construct () {

		//Load all the Object.
		loadBackground("img/background.jpg");
		loadMushroom("TapThemAll/bMushroom.png");
		resize ();
		
		//Add the Sprite to stage.
		addChild (background);
		addChild (mushroom);
		
		//Handle resize
		stage.addEventListener (Event.RESIZE, stage_onResize);
		
	}
	
	
	override private function resize () {
		resizeBackground();
		resizeMushroom();
	}
	
	
}
