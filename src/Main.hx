package;

import game.common.scene.LevelManager;
import nme.display.Bitmap;
import nme.display.Sprite;
import nme.display.StageAlign;
import nme.display.StageScaleMode;
import nme.events.Event;
import nme.Assets;
import nme.Lib;
import game.tap.TapemALvl;



/**
 * ...
 * @author Yang Wang
 */

class Main extends Sprite 
{

	public function new() 
	{
		super();
		#if iphone
		Lib.current.stage.addEventListener(Event.RESIZE, init);
		#else
		addEventListener(Event.ADDED_TO_STAGE, init);
		#end
	}

	private function init(e) 
	{
		// entry point
		LevelManager.LEVEL_MANAGER.getInstance().changePages(LevelSel);
		LevelManager.LEVEL_MANAGER.getInstance().isFirstTime = false;
		
	}
	
	static public function main() 
	{
		var stage = Lib.current.stage;
		stage.scaleMode = nme.display.StageScaleMode.NO_SCALE;
		stage.align = nme.display.StageAlign.TOP_LEFT;
	
		Lib.current.addChild(new Main());
	}
	
}
