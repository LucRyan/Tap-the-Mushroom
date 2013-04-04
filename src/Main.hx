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
import engine.sound.SoundSystem;



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
		LevelManager.getInstance().changePages(ShakeIt);
		LevelManager.getInstance().isFirstTime = false;
		
		//TODO: Initialize the Soundsystem
		SoundSystem.getInstance().playSoundFx("PokeMushroom", 1);
		
	}
	
	static public function main() 
	{
		var stage = Lib.current.stage;
		stage.scaleMode = nme.display.StageScaleMode.NO_SCALE;
		stage.align = nme.display.StageAlign.TOP_LEFT;
	
		Lib.current.addChild(new Main());
	}
	
}
