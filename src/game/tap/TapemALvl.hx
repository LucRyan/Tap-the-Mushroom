package game.tap;

import engine.scene.LevelScene;
import format.display.MovieClip;

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

import game.tap.util.MushroomFactory;
import game.tap.mushroom.IMushroom;
import game.tap.util.MushroomPlanter;
import engine.scene.BaseScene;


/**
 * ...
 * @author Yang Wang
 */

class TapemALvl extends LevelScene
{
	
	var mushroomPool : Array<IMushroom> ; // The 40 mushrooms container. 
	var mushPlanter : MushroomPlanter; // The planter instance.
	var tempAnimationIndex : Int; // The index need by animation.
	var animationTimer : Timer;  // The Timer controls whole animation loop.
	var playTimer : Timer; // The Timer control each animation start.
	var stopTimer : Timer; /// The Timer controls when the animation should stop.
	
	// Constructor 
	public function new () {	
		super();
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
		mushroomPool[tempAnimationIndex].startJump();
	}
	
	/**
	 * The animation stop.
	 * @param	event when the stopTimer calls.
	 */
	private function stopAnimation(event: TimerEvent) {
		mushroomPool[tempAnimationIndex].stopJump();
	}
	// =========================== Animation Part Ends ================================//
	
	
	/**
	 * Override the construct which will load the stage when the level start.
	 */
	override private function construct () {
		//Initialize the instances.
		mushPlanter = new MushroomPlanter();
		mushroomPool = new Array<IMushroom>();

		
		//Load all the Object.
		loadBackground("img/background.jpg");
		mushroomPool = mushPlanter.plantMushrooms();
		
		
		//Add the Sprite to stage.
		resize ();
		addBasicObjects();
		for (i in 0 ... 40) {
			var tempMush : IMushroom = mushroomPool[i];
			mushPlanter.resizeMushroom(tempMush, i, 5, 8, 2.2, 3.9);
			addChild(tempMush.mushClip);
			tempMush.mushClip.gotoAndStop(2);
		}
		#if flash 
		addEventListener(MouseEvent.CLICK, stopAnimationLoop, false, 0 , false);
		#else if android
		
		#end 
		
		//Start Animation on this stage
		initializeTimer();
		animationTimer.start();

		//Handle resize
		stage.addEventListener (Event.RESIZE, stage_onResize);
	}
	
	override private function resizeButtons() : Void {
		menuButton.resizeMovieClip(menuButton.objectClip, 527, 132, 9, 1.0 / 13.0, 17.0 / 18.0);
		restartButton.resizeMovieClip(restartButton.objectClip, 231, 184, 22, 17.0 / 18.0, 17.0 / 18.0); 
		countDownTimer.resizeMovieClip(countDownTimer.objectClip, 524, 174, 7, 1.0 / 10.0, 1.0 / 12.0);
		countDownTimer.resizeText(countDownTimer.getTextContent());
	}
	
	override private function addBasicObjects() : Void {
		addChild(background);
		addChild(menuButton.objectClip);
		addChild(restartButton.objectClip);
		addChild(countDownTimer.objectClip);
		addChild(countDownTimer.displayText);
	}
	
	override private function resize () {
		resizeButtons();
		resizeBackground();
		for (i in 0 ... 40) {
			var tempMush : IMushroom = mushroomPool[i];
			mushPlanter.resizeMushroom(tempMush, i, 5, 8, 2.2, 4);
		}
	}
	
	
}
