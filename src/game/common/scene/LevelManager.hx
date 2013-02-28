package game.common.scene;
import nme.display.Sprite;
import engine.scene.BaseScene;
import nme.events.Event;
import game.tap.TapemALvl;
import engine.sound.SoundSystem;
import nme.events.TimerEvent;
import engine.utils.DeltaTime;

/**
 * ...
 * @author Yang Wang
 */

 enum Levels {
	 TapEmALL;
	 ScoreBoards;
 }

class LevelManager extends Sprite
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
		super();
		construct();
	}
	
	var currentStage : BaseScene;
	//
    private function construct() {
		currentStage = new TapemALvl();
		//currentStage = new ScoreBoard();
		addChild(currentStage);
	}
	
	//TODO: Haven't figured out how to Safe Delete object and release memory.
	public function startFadeOut() {
		for(i in 0 ... 5)
		DeltaTime.DELTA_TIME.getInstance().wait(40 * i , fadeOut);
		DeltaTime.DELTA_TIME.getInstance().wait(200, restart);
	}
	
	private function fadeOut(event: TimerEvent) {
		currentStage.alpha -= 0.2;
	}
	
	private function restart(?event : TimerEvent) {
		currentStage.delete();
		//TODO: CHANGE LEVEL
		currentStage = new TapemALvl();
		addChild(currentStage);
	}
	
	public function changePages(levelId : Levels) {
		currentStage.delete();
		switch(levelId) {
			case TapEmALL:
				currentStage = new TapemALvl();
			case ScoreBoards:
				currentStage = new ScoreBoard();
		}
		
		addChild(currentStage);
	}
	
	
	
	
}