package game.common.scene;
import nme.display.Sprite;
import engine.scene.BaseScene;
import nme.events.Event;
import game.tap.TapemALvl;
import engine.sound.SoundSystem;
import nme.events.TimerEvent;
import engine.utils.MTimer;
import nme.Lib;

/**
 * ...
 * @author Yang Wang
 */

 enum Levels {
	 TapEmALL;
	 ScoreBoards;
 }

class LevelManager
{
	// Use for singleton.
	public static var LEVEL_MANAGER = new LevelManager();
	
	/**
	 * Singleton function
	 * @return
	 */
	public function getInstance() : LevelManager{
		if ( LEVEL_MANAGER == null) {
			LEVEL_MANAGER = new LevelManager();
		}
		return LEVEL_MANAGER;
	}
	
	private function new() 
	{

	}
	
	var currentStage : BaseScene;
	//
	public function getStage() : Sprite {
		currentStage = new TapemALvl();
		return currentStage;
	}
	
	//TODO: Haven't figured out how to Safe Delete object and release memory.
	public function startFadeOut() {
		for(i in 0 ... 5)
		MTimer.TIMER.getInstance().wait(40 * i , fadeOut);
		//Restart
		MTimer.TIMER.getInstance().wait(200, restart);
	}
	
	private function fadeOut(event: TimerEvent) {
		currentStage.alpha -= 0.2;
	}
	
	private function restart(?event : TimerEvent) {
		Lib.current.removeChild(currentStage);
		currentStage.delete();
		currentStage = null;
		//TODO: CHANGE LEVEL
		currentStage = new TapemALvl();
		Lib.current.addChild(currentStage);
	}
	
	public function changePages(levelId : Levels) {
		Lib.current.removeChild(currentStage);
		currentStage.delete();
		currentStage = null;
		switch(levelId) {
			case TapEmALL:
				currentStage = new TapemALvl();
			case ScoreBoards:
				currentStage = new ScoreBoard();
		}
		
		Lib.current.addChild(currentStage);
	}
	
	
	
	
}