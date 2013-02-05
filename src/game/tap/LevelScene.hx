package game.tap;

import format.display.MovieClip;
import nme.display.Bitmap;
import nme.display.Sprite;
import nme.display.StageAlign;
import nme.display.StageScaleMode;
import nme.events.Event;
import nme.Assets;
import nme.events.TimerEvent;
import nme.Lib;
import com.eclecticdesignstudio.motion.Actuate;
import nme.utils.Timer;

import game.tap.mushroom.MushroomFactory;
import game.tap.mushroom.Mushroom;
import engine.scene.BaseScene;


/**
 * ...
 * @author Yang Wang
 */

class LevelScene extends BaseScene
{
	
	var mushroomPool : Array<Mushroom> ; // The 40 mushrooms container. 
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
	
	private function initializeTimer() {
		
		animationTimer = new Timer(2000 + (35 / 30) * 1000, 0);
		animationTimer.addEventListener(TimerEvent.TIMER, animationLoop, false, 0, false);
		
		playTimer = new Timer(1000, 1);
		playTimer.addEventListener(TimerEvent.TIMER, playAnimation, false, 0, false);
		
		stopTimer = new Timer((35/30)*1000 + 1000, 1);
		stopTimer.addEventListener(TimerEvent.TIMER, stopAnimation, false, 0, false);
	}
	
	private function animationLoop(event: TimerEvent) {
		playTimer.start();
		stopTimer.start();
	}

	private function playAnimation(event: TimerEvent) {
		tempAnimationIndex = Std.int(Math.random() * 40); 
		mushroomPool[tempAnimationIndex].mushClip.play();
	}
	
	private function stopAnimation(event: TimerEvent) {
		mushroomPool[tempAnimationIndex].mushClip.gotoAndStop(2);
	}
	
	// -------------------------- Animation Part Ends -----------------------------------//
	
	/**
	 * Override the construct which will load the stage when the level start.
	 */
	override private function construct () {
		//Initialize the instances.
		mushPlanter = new MushroomPlanter();
		mushroomPool = new Array<Mushroom>();
		
		//Load all the Object.
		loadBackground("img/background.jpg");
		mushroomPool = mushPlanter.plantMushrooms();
		
		
		//Add the Sprite to stage.
		resize ();
		addChild (background);
		for (i in 0 ... 40) {
			var tempMush : Mushroom = mushroomPool[i];
			mushPlanter.resizeMushroom(tempMush, i, 5, 8, 2.2, 4);
			addChild (tempMush.mushClip);
			tempMush.mushClip.gotoAndStop(2);
		}
		
		//Start Animation on this stage
		initializeTimer();
		animationTimer.start();

		//Handle resize
		stage.addEventListener (Event.RESIZE, stage_onResize);
	}
	
	override private function resize () {
		resizeBackground();
		for (i in 0 ... 40) {
			var tempMush : Mushroom = mushroomPool[i];
			mushPlanter.resizeMushroom(tempMush, i, 5, 8, 2.2, 4);
		}
	}
	
	
}
