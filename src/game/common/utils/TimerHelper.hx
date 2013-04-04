package game.common.utils;
import game.common.displayItem.CountDownTimer;
import nme.display.Sprite;

/**
 * ...
 * @author Yang Wang
 */
class TimerHelper
{

	var countDownTimer : CountDownTimer;
	
	public function new(?totalTime : Int = 5000) 
	{
		initializeTimer(totalTime);
	}
	
	public function delete() {
		countDownTimer.delete();
	}
	
	private function initializeTimer(?totalTime : Int) : Void{
		countDownTimer = new CountDownTimer(totalTime);
	}
	
	public function resizeTimer() : Void {
		countDownTimer.resizeMovieClip(countDownTimer.objectClip, 524, 174, 7, 1.0 / 10.0, 1.0 / 12.0);
		countDownTimer.resizeText(countDownTimer.getTextContent());
	}
	
	public function addTimerTo(stage : Sprite) {
		resizeTimer();
		stage.addChild(countDownTimer.objectClip);
		stage.addChild(countDownTimer.displayText);
	}
	
	public function getCountTimer() : CountDownTimer {
		return countDownTimer;
	}
}