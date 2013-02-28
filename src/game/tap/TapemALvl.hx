package game.tap;

import game.common.scene.LevelScene;
import format.display.MovieClip;
import game.common.utils.ButtonAdder;

import nme.display.Bitmap;
import nme.display.Sprite;
import nme.display.StageAlign;
import nme.display.StageScaleMode;
import nme.events.Event;
import nme.Assets;
import nme.events.TimerEvent;
import nme.events.MouseEvent;
import nme.Lib;
import com.eclecticdesignstudio.motion.Actuate;
import nme.utils.Timer;

import game.common.displayItem.CountDownTimer;
import game.tap.mushroom.Mushroom;
import game.tap.mushroom.MushroomController;
import game.tap.util.MushroomFactory;
import game.tap.util.MushroomPlanter;
import engine.utils.ScreenShaker;
import engine.scene.BaseScene;
import engine.utils.SafeRemover;
import engine.sound.SoundSystem;
import engine.utils.DeltaTime;
import game.common.scene.LevelManager;
import game.common.utils.ScoreSystem;

/**
 * ...
 * @author Yang Wang
 */

class TapemALvl extends LevelScene
{
	
	var mushroomPool : Array<Mushroom> ; // The 40 mushrooms container. 
	var mushPlanter : MushroomPlanter; // The planter instance.
	var mushController : MushroomController; //
	var shaker : ScreenShaker; //
	var buttonAdder : ButtonAdder;
	
	var tempAnimationIndex : Int; // The index need by animation.
	var animationTimer : Timer;  // The Timer controls whole animation loop.
	var playTimer : Timer; // The Timer control each animation start.
	var stopTimer : Timer; /// The Timer controls when the animation should stop.
	
	// Constructor 
	public function new () {	
		super();
	}
	
	override public function delete() {
		untyped __delete__(TapemALvl, "mushroomPool");
		untyped __delete__(TapemALvl, "mushPlanter");
		untyped __delete__(TapemALvl, "mushController");
		untyped __delete__(TapemALvl, "shaker");
		untyped __delete__(TapemALvl, "buttonAdder");
		untyped __delete__(TapemALvl, "tempAnimationIndex");
		untyped __delete__(TapemALvl, "animationTimer");
		untyped __delete__(TapemALvl, "stopTimer");
		animationTimer.stop();
		countDownTimer.stopCount();
		this.removeEventListener(Event.ADDED_TO_STAGE, this_onAddedToStage, false);
		this.removeEventListener(Event.RESIZE, stage_onResize, false);
		this.removeEventListener(MouseEvent.CLICK, stopAnimationLoop, false);
		SafeRemover.safeRemove(this);
	}
	
	// -------------------------- Animation Part ---------------------------------------//
	/**
	 * Initialize all three timer, and add different listener to them.
	 */
	private function initializeTimer() {
		animationTimer = new Timer(2000 + (35 / 30) * 1000, 0);
		animationTimer.addEventListener(TimerEvent.TIMER, animationLoop, false, 0, false);
		
		playTimer = new Timer(1000, 1);
		playTimer.addEventListener(TimerEvent.TIMER, playAnimation, false, 0, false);
		
		stopTimer = new Timer((35/30)*1000 + 1000, 1);
		stopTimer.addEventListener(TimerEvent.TIMER, stopAnimation, false, 0, false);
	}
	
	/**
	 * The Whole Animation Loop.
	 * @param	event is the timeEvent triggers when 1 loop finished.
	 */
	private function animationLoop(event: TimerEvent) {
		playTimer.start();
		stopTimer.start();
	}
	/**
	 * Stop The Whole Animation Loop.
	 * @param	event is the timeEvent triggers when 1 loop finished.
	 */
	private function stopAnimationLoop(event : MouseEvent) {
		animationTimer.stop();
		removeEventListener(MouseEvent.CLICK, stopAnimationLoop, false);
		countDownTimer.startCount();
	}
	/**
	 * The animation start.
	 * @param	event when the playTimer calls.
	 */
	private function playAnimation(event: TimerEvent) {
		tempAnimationIndex = Std.int(Math.random() * 40); 
		mushController.startJump(mushroomPool[tempAnimationIndex]);
	}
	
	/**
	 * The animation stop.
	 * @param	event when the stopTimer calls.
	 */
	private function stopAnimation(event: TimerEvent) {
		mushController.stopJump(mushroomPool[tempAnimationIndex]);
	}
	
	/**
	 * 
	 * @param	event
	 */
	private function finished(event: TimerEvent) : Void  {
		var mushroom : Mushroom;
		ScoreSystem.SCORE_SYSTEM.getInstance().checkScoreTEM(mushroomPool);
		for (mushroom in mushroomPool) {
			mushroom.objectClip.buttonMode = false;
			mushroom.objectClip.removeEventListener(MouseEvent.CLICK, mushroom.mouseClick, false);
		}
		
		shaker.startAnimation(this);
		DeltaTime.DELTA_TIME.getInstance().wait(1000, goToScoreBoard);
	}
	// =========================== Animation Part Ends ================================//
	
	/**
	 * Tic function
	 */
	private function update(event: TimerEvent) {
		
	}
	
	/**
	 * Page transfer
	 * @param	event
	 */
	private function goToScoreBoard(event: TimerEvent) {
		LevelManager.LEVEL_MANAGER.getInstance().changePages(ScoreBoards);
	}
	
	/**
	 * Override the construct which will load the stage when the level start.
	 */
	override private function construct () {
		//Initialize the instances.
		countDownTimer = new CountDownTimer();
		mushPlanter = new MushroomPlanter();
		mushroomPool = new Array<Mushroom>();
		mushController = new MushroomController();
		shaker = new ScreenShaker();
		buttonAdder = new ButtonAdder();
		DeltaTime.DELTA_TIME.getInstance().initializeTimer(update);
		
		//Load all the Object.
		loadBackground("img/background.jpg");
		restart();
	}
	
	//
	override public function restart() : Void {
		mushroomPool = mushPlanter.plantMushrooms();
		
		//Add the Sprite to stage.
		resize ();
		addBasicObjects();
		
		for (i in 0 ... 40) {
			var tempMush : Mushroom = mushroomPool[i];
			mushPlanter.resizeMushroom(tempMush, i, 5, 8, 2.2, 3.9);
			addChild(tempMush.objectClip);
			tempMush.objectClip.gotoAndStop(2);
		}
		#if flash 
		addEventListener(MouseEvent.CLICK, stopAnimationLoop, false, 0 , false);
		#else if android
		//TODO: ADD FUNCTIONS. OR THINK ABOUT HOW TO REFACTOR.
		#end 
		
		//Start Animation on this stage
		initializeTimer();
		animationTimer.start();
		//Handle resize
		stage.addEventListener (Event.RESIZE, stage_onResize);
		//Handle Finished
		countDownTimer.setCompleteEvent(finished);
	}
	
	// TODO: THIS FUNCTION NEED REFACTOR!!!! THINK ABOUT OCP, TRY TO USE
	private function resizecountDownTimer() : Void {
		countDownTimer.resizeMovieClip(countDownTimer.objectClip, 524, 174, 7, 1.0 / 10.0, 1.0 / 12.0);
		countDownTimer.resizeText(countDownTimer.getTextContent());
	}
	
	// TODO: THIS FUNCTION NEED REFACTOR!!!!
	override private function addBasicObjects() : Void {
		addChild(background);
		addChild(countDownTimer.objectClip);
		addChild(countDownTimer.displayText);
		buttonAdder.addButtons(this);
	}
	
	override private function resize () {
		resizecountDownTimer();
		buttonAdder.resizeButtons();
		resizeBackground();
		for (i in 0 ... 40) {
			var tempMush : Mushroom = mushroomPool[i];
			mushPlanter.resizeMushroom(tempMush, i, 5, 8, 2.2, 4);
		}
	}
	
	
}
