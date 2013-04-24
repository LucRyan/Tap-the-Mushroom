package game.levels.tap;

import format.display.MovieClip;
import game.common.utils.ButtonHelper;
import game.common.utils.TimerHelper;
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
import game.levels.tap.mushroom.Mushroom;
import game.levels.tap.mushroom.MushroomController;
import game.levels.tap.util.MushroomFactory;
import game.levels.tap.util.MushroomPlanter;
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
	var buttonHelper : ButtonHelper;
	var timerHelper : TimerHelper; // Count Down Timer's background.
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
		buttonHelper.delete();
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
		timerHelper.getCountTimer().startCount();
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
	 * Call this function when time up.
	 * @param	event
	 */
	private function finished() : Void  {
		var mushroom : Mushroom;
		ScoreSystem.getInstance().checkScoreTEM(mushroomPool);
		for (mushroom in mushroomPool) {
			mushroom.objectClip.buttonMode = false;
			mushroom.objectClip.removeEventListener(MouseEvent.CLICK, mushroom.mouseClick, false);
		}
		
		shaker.startAnimation(this);
		MTimer.TIMER.getInstance().wait(1000, goToScoreBoard);
	}
	// =========================== Animation Part Ends ================================//
	
	/**
	 * Page transfer
	 * @param	event
	 */
	private function goToScoreBoard(event: TimerEvent) {
		LevelManager.getInstance().changePages(ScoreBoards);
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

	}
	
	private function initialObjects() :Void {
		//Initialize the instances.
		timerHelper = new TimerHelper(5000);
		mushPlanter = new MushroomPlanter();
		mushroomPool = new Array<Mushroom>();
		mushController = new MushroomController();
		shaker = new ScreenShaker();
		buttonHelper = new ButtonHelper();
		//Load all the Object.
		loadBackground("img/background.jpg");
		mushroomPool = mushPlanter.plantMushrooms();
	}
	
	private function addBasicObjects() : Void {
		addChild(background);
		timerHelper.addTimerTo(this);
		buttonHelper.addButtons(this);
	}
	
	override private function resize () {
		super.resize();
		buttonHelper.resizeButtons();
		timerHelper.resizeTimer();
		for (i in 0 ... 40) {
			var tempMush : Mushroom = mushroomPool[i];
			mushPlanter.resizeMushroom(tempMush, i, 5, 8, 2.2, 4);
		}
	}
	
	
	//--------------------------- Update Function --------------------------------//
	/**
	 * Update function
	 */
	override private function update(?deltaTime : Float) : Void {
		timerHelper.getCountTimer().tick(); // Timer update
		//
		if(updateAnimationFlag){
			updateAnimation();
		}
		if (timerHelper.getCountTimer().isComplete()) {
			finished();
			timerHelper.getCountTimer().resetComplete();
		}
	}
	
}
