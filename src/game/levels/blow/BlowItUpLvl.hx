package game.levels.blow;
import engine.scene.BaseScene;
import engine.utils.ScreenShaker;
import game.common.utils.ButtonHelper;
import game.levels.blow.actor.ActorController;
import game.levels.blow.actor.InflatorBody;
import game.levels.blow.actor.InflatorHandle;
import game.levels.blow.actor.Mushroom;
import nme.events.Event;
import game.common.utils.TimerHelper;
import nme.events.MouseEvent;
import nme.Lib;
import game.common.utils.ScoreSystem;
import nme.events.TimerEvent;
import engine.utils.MTimer;
import game.common.scene.LevelManager;
import game.common.scene.ScoreBoard;
import engine.sound.SoundSystem;

/**
 * ...
 * @author Yang Wang
 */
class BlowItUpLvl extends BaseScene
{
	var shaker : ScreenShaker; //
	var buttonHelper : ButtonHelper;
	var timerHelper : TimerHelper; // Count Down Timer's background.
	var mushroom : Mushroom;
	var inflatorBody : InflatorBody;
	var inflatorHandle : InflatorHandle;
	var controller : ActorController;
	var handlePosY: Float = 210.0;
	var lastY : Float = 210;
	var upFlag : Bool = false;
	var mushSize : Float = 4.0;
	var score : Int = 0;
	
	public function new() 
	{
		super();
		//Add the enter frame listenr.
		addEventListener (Event.ENTER_FRAME, this_onEnterFrame);
		
	}
	
	override public function delete() {
		super.delete();
		buttonHelper.delete();
		super.removeChild(background);
		this.removeEventListener(MouseEvent.MOUSE_MOVE, mouseMove, false);
		this.removeEventListener(Event.RESIZE, stage_onResize, true);
		this.removeEventListener(Event.ENTER_FRAME, this_onEnterFrame, false);
	}
	
	private function finished() : Void  {
		shaker.startAnimation(this);
		ScoreSystem.getInstance().checkScoreSKT(score);
		MTimer.TIMER.getInstance().wait(1000, goToScoreBoard);
	}
	
	/**
	 * Page transfer
	 * @param	event
	 */
	private function goToScoreBoard(event: TimerEvent) {
		LevelManager.getInstance().changePages(ScoreBoards);
	}
	
	//-------------------------Basic Function---------------------------------------
	/**
	 * Override the construct which will load the stage when the level start.
	 */
	override private function construct () {
		initialObjects();
		//Add the Sprite to stage.
		resize ();
		addBasicObjects();

		
		//Handle resize
		stage.addEventListener(MouseEvent.MOUSE_MOVE, mouseMove, false, 0 , false);
		stage.addEventListener(Event.RESIZE, stage_onResize);
	}
	
	private function initialObjects() :Void {
		//Initialize the instances.
		shaker = new ScreenShaker();
		buttonHelper = new ButtonHelper();
		timerHelper = new TimerHelper(5000);
		mushroom = new Mushroom();
		inflatorBody = new InflatorBody();
		inflatorHandle = new InflatorHandle();
		controller = new ActorController();
		//Load all the Object.
		loadBackground("img/background.jpg");
	}
	
	private function addBasicObjects() : Void {
		addChild(background);
		timerHelper.addTimerTo(this);
		buttonHelper.addButtons(this);
		addChild(mushroom.objectClip);
		addChild(inflatorHandle.objectClip);
		addChild(inflatorBody.objectClip);
	}
	
	
	override private function resize () {
		super.resize();
		buttonHelper.resizeButtons();
		controller.resizeMovieClip(mushroom.objectClip, 188, 155, 4.0, 400, 240);
		controller.resizeMovieClip(inflatorBody.objectClip, 210, 110, 6.0, 550, 240);
		controller.resizeMovieClip(inflatorHandle.objectClip, 83, 107, 3.50, 550, handlePosY);
	}
	
	
	//---------------------------Update Function------------------------------------------
	override private function update(?deltaTime : Float) : Void {
		timerHelper.getCountTimer().tick(); // Timer update
		//
		controller.resizeMovieClip(inflatorHandle.objectClip, 83, 107, 3.50, 550, handlePosY);
		if (timerHelper.getCountTimer().isComplete()) {
			this.removeEventListener(MouseEvent.MOUSE_MOVE, mouseMove, false);
			finished();
			timerHelper.getCountTimer().resetComplete();
		}
	}
	
	//-------------------------Event Handler----------------------------
	private function mouseMove(mouseEvent : MouseEvent) : Void {
		if ( ((Lib.current.stage.stageHeight / 8.0) <= mouseEvent.stageY - lastY) && upFlag) 
		{
			lastY = mouseEvent.stageY;
			handlePosY = 260;
			upFlag = false;
		}
		else if ( ((Lib.current.stage.stageHeight / 8.0) <= lastY - mouseEvent.stageY)&& !upFlag) 
		{
			SoundSystem.getInstance().playSoundFx("PokeMushroom", 1);
			timerHelper.getCountTimer().startCount();
			lastY = mouseEvent.stageY;
			handlePosY = 210;
			upFlag = true;
			mushSize += 0.5;
			controller.resizeMovieClip(mushroom.objectClip, 188, 155, mushSize, 400, 240);
			score++;
		}
	}
}