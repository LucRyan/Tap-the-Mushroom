package game.common.scene;
import engine.objects.TextObject;
import engine.scene.BaseScene;
import game.common.utils.ButtonAdder;
import nme.events.Event;
import engine.objects.SceneObject;
import engine.utils.SafeRemover;
import game.common.displayItem.Stars;
import game.common.utils.ScoreSystem;
import engine.utils.DeltaTime;

/**
 * ...
 * @author Yang Wang
 */

class ScoreBoard extends BaseScene
{

	var buttonAdder : ButtonAdder; //
	var currentScoreText : TextObject; //
	var currentScrVl : TextObject; //
	
	var bestScoreText : TextObject; //
	var bestScrVl : TextObject; //

	var levelCompleteInfoText : TextObject; //
	var starsBest : Array<Stars>; //
	var starsCurrent : Array<Stars>; //
 
	var scoreTEM : Int; //
	
	public function new() 
	{
		super();
	}
	
	override public function delete() {
		SafeRemover.safeRemove(this);
	}
	
	override private function construct () {
		buttonAdder = new ButtonAdder();
		currentScoreText = new TextObject("fonts/ScoreFont.ttf");
		bestScoreText = new TextObject("fonts/ScoreFont.ttf");
		levelCompleteInfoText = new TextObject("fonts/ScoreFont.ttf");
		currentScrVl = new TextObject("fonts/ScoreFont.ttf");
		bestScrVl = new TextObject("fonts/ScoreFont.ttf");
		starsBest = new Array<Stars>();
		starsCurrent = new Array<Stars>();
		
		//Load all the Object.
		loadBackground("img/background.jpg");
		
		//Add all Object.
		addBasicObjects();
		resize ();
		
		//Handle resize
		stage.addEventListener (Event.RESIZE, stage_onResize);
	}
	
	private function addBasicObjects() : Void {
		addChild(background);
		currentScoreText.addObjectToStage(this);
		bestScoreText.addObjectToStage(this);
		levelCompleteInfoText.addObjectToStage(this);
		currentScrVl.addObjectToStage(this);
		bestScrVl.addObjectToStage(this);
		buttonAdder.addButtons(this);
		for (i in 0 ... 5 ) {
			starsBest[i] = new Stars();
			starsCurrent[i] = new Stars("fonts/ScoreFont.ttf");
			starsCurrent[i].addObjectToStage(this);
			
			//TODO: TEMP DISPLAY!!---------------------
			addChild(starsBest[i].objectClip);
			starsBest[i].objectClip.gotoAndStop(15);
		}
		
		//------------------------------ Get Score ----------------------------------
		scoreTEM = ScoreSystem.SCORE_SYSTEM.getInstance().getScore();
		starsAnimation(scoreTEM, 15, 5);
	}
	
	
	override private function resize () {
		currentScoreText.resizeMovieClip(currentScoreText.objectClip, 359, 219, 15,  2.5 / 10.0, 8 / 12.0);
		currentScoreText.resizeText("Current Score: ", 0xCC9900);
		bestScoreText.resizeMovieClip(bestScoreText.objectClip, 359, 219, 15,  2.1 / 10.0, 5 / 12.0);
		bestScoreText.resizeText("Best Score: ", 0xCC9900);
		levelCompleteInfoText.resizeMovieClip(levelCompleteInfoText.objectClip, 359, 219, 12,  5 / 10.0, 1.5 / 12.0);
		levelCompleteInfoText.resizeText("Level 1 Completed!! ", 0xFFFFFF);
		
		//TODO: TEMP DISPLAY!!---------------------------------
		bestScrVl.resizeMovieClip(bestScrVl.objectClip, 359, 219, 15,  4 / 10.0, 5 / 12.0);
		bestScrVl.resizeText("36 ", 0xCC9900);
		currentScrVl.resizeMovieClip(currentScrVl.objectClip, 359, 219, 13,  4.6 / 10.0, 8 / 12.0);
		currentScrVl.resizeText(Std.string(scoreTEM), 0xCC9900);
		//------------------------------------
		
		buttonAdder.resizeButtons();
		resizeBackground();
		for (i in 0 ... 5 ) {
			starsBest[i].resizeMovieClip(starsBest[i].objectClip, 100, 100, 40, ( i / 3 + 3.8 )/ 10.0, 6 / 12.0);
			starsCurrent[i].resizeMovieClip(starsCurrent[i].objectClip, 100, 100, 24, ( i / 1.8 + 4.5 ) / 10.0, 9.2 / 12.0);
			//TODO: JUST THIS ONE.
			starsCurrent[i].resizeText( Std.string(15 + (i * 5)), 0xCC9900);
		}
	}
	
	
	public function starsAnimation(score : Int, lowerBound : Int, difference : Int) : Void {
		if (score < lowerBound) { //TODO: > for test
			
		}else if ( score >= lowerBound && score < lowerBound + difference) {
			starsCurrent[0].playAnimation();
			DeltaTime.DELTA_TIME.getInstance().wait(16/30 * 1000, starsCurrent[0].stopAnimation);
		}else if ( score >= lowerBound + difference && score < lowerBound + difference * 2) {
			starsCurrent[0].playAnimation();
			DeltaTime.DELTA_TIME.getInstance().wait(16/30 * 1000, starsCurrent[0].stopAnimation);
			DeltaTime.DELTA_TIME.getInstance().wait(16/30 * 1000, starsCurrent[1].playAnimation);
			DeltaTime.DELTA_TIME.getInstance().wait(16/30 * 1000 * 2, starsCurrent[1].stopAnimation);
		}else if ( score >= lowerBound + difference * 2 && score < lowerBound + difference * 3) {
			starsCurrent[0].playAnimation();
			DeltaTime.DELTA_TIME.getInstance().wait(16/30 * 1000, starsCurrent[0].stopAnimation);
			DeltaTime.DELTA_TIME.getInstance().wait(16/30 * 1000, starsCurrent[1].playAnimation);
			DeltaTime.DELTA_TIME.getInstance().wait(16 / 30 * 1000 * 2, starsCurrent[1].stopAnimation);
			DeltaTime.DELTA_TIME.getInstance().wait(16/30 * 1000 * 2, starsCurrent[2].playAnimation);
			DeltaTime.DELTA_TIME.getInstance().wait(16 / 30 * 1000 * 3, starsCurrent[2].stopAnimation);
		}else if ( score >= lowerBound + difference * 2 && score < lowerBound + difference * 4) {
			starsCurrent[0].playAnimation();
			DeltaTime.DELTA_TIME.getInstance().wait(16/30 * 1000, starsCurrent[0].stopAnimation);
			DeltaTime.DELTA_TIME.getInstance().wait(16/30 * 1000, starsCurrent[1].playAnimation);
			DeltaTime.DELTA_TIME.getInstance().wait(16 / 30 * 1000 * 2, starsCurrent[1].stopAnimation);
			DeltaTime.DELTA_TIME.getInstance().wait(16/30 * 1000 * 2, starsCurrent[2].playAnimation);
			DeltaTime.DELTA_TIME.getInstance().wait(16 / 30 * 1000 * 3, starsCurrent[2].stopAnimation);
			DeltaTime.DELTA_TIME.getInstance().wait(16/30 * 1000 * 3, starsCurrent[3].playAnimation);
			DeltaTime.DELTA_TIME.getInstance().wait(16 / 30 * 1000 * 4, starsCurrent[3].stopAnimation);
		}else {
			starsCurrent[0].playAnimation();
			DeltaTime.DELTA_TIME.getInstance().wait(16/30 * 1000, starsCurrent[0].stopAnimation);
			DeltaTime.DELTA_TIME.getInstance().wait(16/30 * 1000, starsCurrent[1].playAnimation);
			DeltaTime.DELTA_TIME.getInstance().wait(16 / 30 * 1000 * 2, starsCurrent[1].stopAnimation);
			DeltaTime.DELTA_TIME.getInstance().wait(16/30 * 1000 * 2, starsCurrent[2].playAnimation);
			DeltaTime.DELTA_TIME.getInstance().wait(16 / 30 * 1000 * 3, starsCurrent[2].stopAnimation);
			DeltaTime.DELTA_TIME.getInstance().wait(16/30 * 1000 * 3, starsCurrent[3].playAnimation);
			DeltaTime.DELTA_TIME.getInstance().wait(16 / 30 * 1000 * 4, starsCurrent[3].stopAnimation);
			DeltaTime.DELTA_TIME.getInstance().wait(16/30 * 1000 * 4, starsCurrent[4].playAnimation);
			DeltaTime.DELTA_TIME.getInstance().wait(16 / 30 * 1000 * 5, starsCurrent[4].stopAnimation);
		}
	}
}