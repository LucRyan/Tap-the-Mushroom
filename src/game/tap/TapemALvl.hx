package game.tap;

import format.display.MovieClip;
import game.common.utils.ButtonAdder;
import haxe.Log;

import nme.display.Bitmap;
import nme.display.Sprite;
import nme.display.StageAlign;
import nme.display.StageScaleMode;
import nme.events.Event;
import nme.Assets;
import nme.events.TimerEvent;
import nme.events.MouseEvent;
import nme.events.TouchEvent;
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
import engine.utils.MTimer;
import game.common.scene.LevelManager;
import game.common.utils.ScoreSystem;

/**
 * ...
 * @author Yang Wang
 */

class TapemALvl extends BaseScene
{
	//-----------------------------------     Variables     ---------------------------------------
	var mushroomPool : Array<Mushroom> ; // The 40 mushrooms container. 
	var mushPlanter : MushroomPlanter; // The planter instance.
	var mushController : MushroomController; //
	var shaker : ScreenShaker; //
	var buttonAdder : ButtonAdder;
	var countDownTimer : CountDownTimer; // Count Down Timer's background.
	var tempAnimationIndex : Int; // The index need by animation.
	
	//--------- Animation Variables ----------//
	var lastAnimationStamp  : Float = 0; // AnimationStamp
	inline static var SJUMP_DURATION : Float = (35 / 30) * 1000;
	inline static var WHOLE_DURATION : Float = 2000 + (35 / 30) * 1000;
	var updateAnimationFlag : Bool = true;
	
	//----------------------------------------------------------------------------------------------

	
	//---------------------------------      Functions     -----------------------------------------
	// Constructor 
	public function new () {	
		super();
		//Add the enter frame listenr.
		addEventListener (Event.ENTER_FRAME, this_onEnterFrame);
	}
	
	override public function delete() {
		super.delete();
		countDownTimer.stopCount();
		buttonAdder.delete();
		super.removeChild(background);
		this.removeEventListener(Event.RESIZE, stage_onResize, true);
		this.removeEventListener(Event.ENTER_FRAME, this_onEnterFrame, false);
		this.removeEventListener(MouseEvent.CLICK, stopAnimationLoop, false);
	}
	
	// -------------------------- Animation Part ---------------------------------------//
	/**
	 * Stop The Whole Animation Loop.
	 * @param	event is the timeEvent triggers when 1 loop finished.
	 */
	private function stopAnimationLoop(?event: Event) {
		updateAnimationFlag = false;
		removeEventListener(MouseEvent.CLICK, stopAnimationLoop, false);
		countDownTimer.startCount();
	}
	
	/**
	 * Update the animation, mushroom jumps.
	 */	
	private function updateAnimation() {
		if((WHOLE_DURATION * 1.5 <= Lib.getTimer() - lastAnimationStamp))
		{
			//Start Mushroom jump.
			tempAnimationIndex = Std.int(Math.random() * 40); 
			lastAnimationStamp = Lib.getTimer();
			mushController.startJump(mushroomPool[tempAnimationIndex]);
			//Stop Mushroom jump
		}
		if (SJUMP_DURATION <= Lib.getTimer() - lastAnimationStamp)
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
		MTimer.TIMER.getInstance().wait(1000, goToScoreBoard);
	}
	// =========================== Animation Part Ends ================================//
	
	/**
	 * Update function
	 */
	override private function update(?deltaTime : Float) : Void {
		if(updateAnimationFlag)
			updateAnimation();
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
		initialObjects();
		//Add the Sprite to stage.
		resize ();
		addBasicObjects();
		
		for (i in 0 ... 40) {
			var tempMush : Mushroom = mushroomPool[i];
			mushPlanter.resizeMushroom(tempMush, i, 5, 8, 2.2, 3.9);
			addChild(tempMush.objectClip);
			tempMush.objectClip.gotoAndStop(2);
		}
		addEventListener(MouseEvent.CLICK, stopAnimationLoop, false, 0 , false);
		
		//Handle resize
		stage.addEventListener(Event.RESIZE, stage_onResize);
		//Handle Finished
		countDownTimer.setCompleteEvent(finished);
	}
	
	private function initialObjects() :Void {
		//Initialize the instances.
		countDownTimer = new CountDownTimer();
		mushPlanter = new MushroomPlanter();
		mushroomPool = new Array<Mushroom>();
		mushController = new MushroomController();
		shaker = new ScreenShaker();
		buttonAdder = new ButtonAdder();
		//Load all the Object.
		loadBackground("img/background.jpg");
		mushroomPool = mushPlanter.plantMushrooms();
	}
	
	// TODO: THIS FUNCTION NEED REFACTOR!!!! THINK ABOUT OCP, TRY TO USE
	private function resizecountDownTimer() : Void {
		countDownTimer.resizeMovieClip(countDownTimer.objectClip, 524, 174, 7, 1.0 / 10.0, 1.0 / 12.0);
		countDownTimer.resizeText(countDownTimer.getTextContent());
	}
	
	// TODO: THIS FUNCTION NEED REFACTOR!!!!
	private function addBasicObjects() : Void {
		addChild(background);
		addChild(countDownTimer.objectClip);
		addChild(countDownTimer.displayText);
		buttonAdder.addButtons(this);
	}
	
	override private function resize () {
		super.resize();
		resizecountDownTimer();
		buttonAdder.resizeButtons();
		for (i in 0 ... 40) {
			var tempMush : Mushroom = mushroomPool[i];
			mushPlanter.resizeMushroom(tempMush, i, 5, 8, 2.2, 4);
		}
	}
	
	
}
