package tap;

import format.display.MovieClip;
import nme.display.Bitmap;
import nme.display.Sprite;
import nme.display.StageAlign;
import nme.display.StageScaleMode;
import nme.events.Event;
import nme.Assets;
import nme.Lib;

import tap.mushroom.MushroomFactory;
import tap.mushroom.Mushroom;



/**
 * ...
 * @author Yang Wang
 */

class LevelScene extends BaseScene
{
	
	var mushroomPool : Array<Mushroom> ;
	
	public function new () {	
		super();
	}
	
	
	private function resizeMushroom (mushroom : Mushroom, offset : Int ) : Void {
		//Size
		var scaleWidth = ((stage.stageWidth  - stage.stageWidth/10) / 8 - stage.stageWidth / 25 ); // margin is width/10, and the scale offset is width/40.
		var scaleHeight = scaleWidth / 188 * 155; // Scale the height with Image ratio.
		mushroom.mushClip.height = scaleHeight;
		mushroom.mushClip.width = scaleWidth;
		mushroom.mushClip.alpha = 1.0;
		//Position
		mushroom.mushClip.x = (stage.stageWidth + mushroom.mushClip.width) / 2 + (offset % 8 - 4 ) * stage.stageWidth/10;
		mushroom.mushClip.y = (stage.stageHeight + mushroom.mushClip.height) / 2 + (offset % 5 - 2.2 ) * stage.stageHeight/8 ;
	}
	
	private function plantMushrooms() : Void {
		var muFactory : MushroomFactory;
		muFactory = new MushroomFactory();

		mushroomPool = new Array<Mushroom>();
		for (i in 0 ... 40) {
			var tempMush : Mushroom = muFactory.createMushroom(None, Std.int( Math.random() * 6));
			resizeMushroom(tempMush, i);
			mushroomPool.push(tempMush);
		}
	}
	
	
	override private function construct () {

		//Load all the Object.
		loadBackground("img/background.jpg");
		plantMushrooms();
		resize ();
		
		//Add the Sprite to stage.
		addChild (background);
		for (i in 0 ... 40) {
			var tempMush : Mushroom = mushroomPool[i];
			resizeMushroom(tempMush, i);
			//tempMush.mushClip.totalFrames();
			//tempMush.mushClip.gotoAndStop(3);
			if (i == 30) {
				tempMush.mushClip.play();
			}
			addChild (tempMush.mushClip);

			
		}
		
		
		//Handle resize
		stage.addEventListener (Event.RESIZE, stage_onResize);
	}
	
	
	override private function resize () {
		resizeBackground();
		for (i in 0 ... 40) {
			var tempMush : Mushroom = mushroomPool[i];
			resizeMushroom(tempMush, i);
		}
	}
	
	
}
