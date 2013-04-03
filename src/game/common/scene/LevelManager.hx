package game.common.scene;
import game.levelmenu.LevelSelection;
import game.shake.ShakeItDnLvl;
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

 enum LevelsEM {
	 LevelSel;
	 TapEmALL;
	 ShakeIt;
	 ScoreBoards;
 }

class LevelManager
{
	// Use for singleton.
	private static var LEVEL_MANAGER = new LevelManager();

	/**
	 * Singleton function
	 * @return
	 */
	public static function getInstance() : LevelManager{
		if ( LEVEL_MANAGER == null) {
			LEVEL_MANAGER = new LevelManager();
		}
		return LEVEL_MANAGER;
	}
	
	private function new() 
	{

	}
	
	var currentStage : BaseScene;
	var currentStageName : LevelsEM;
	public var isFirstTime : Bool = true;

	/**
	 * This function will change levels based on the LevelId.
	 * @param	levelId
	 */
	public function changePages(levelId : LevelsEM) : Void {
		if (isFirstTime == false) {
			Lib.current.removeChild(currentStage);
			currentStage.delete();
			currentStage = null;
		}
		switch(levelId) {
			case LevelSel:
				currentStage = new LevelSelection();
				currentStageName = LevelSel;
			case TapEmALL:
				currentStage = new TapemALvl();
				currentStageName = TapEmALL;
			case ShakeIt:
				currentStage = new ShakeItDnLvl();
				currentStageName = ShakeIt;
			case ScoreBoards:
				currentStage = new ScoreBoard();
		}
		Lib.current.addChild(currentStage);
	}
	
	//-----------------------------Animation Part-------------------------------//
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
		changePages(currentStageName);
	}
	
}