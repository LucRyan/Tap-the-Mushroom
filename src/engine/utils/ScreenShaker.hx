package engine.utils;
import nme.display.Sprite;
import nme.events.TimerEvent;
import nme.utils.Timer;
/**
 * ...
 * @author Yang Wang
 */

enum ShakeState{
	Right;
	Left;
	Origin;
}
class ScreenShaker 
{

	var shakeTimer : Timer;
	var shakeState : ShakeState;
	var screen : Sprite;
	
	public function new(?shakeTimes : Int) 
	{
		shakeState = Origin;
		shakeTimer = new Timer(50, (shakeTimes == null)? 9 : shakeTimes * 3);
		shakeTimer.addEventListener(TimerEvent.TIMER, shakeIt, false, 0, false);
		shakeTimer.addEventListener(TimerEvent.TIMER_COMPLETE, shakeBack, false, 0, false);
	}
	
	private function shakeIt(timeEvent : TimerEvent) : Void {
		if (shakeState == Origin || shakeState == Left) {
			screen.rotation = 0.25;
			shakeState = Right;
		}else {
			screen.rotation = -0.25;
			shakeState = Left;
		}
	}
	
	private function shakeBack(timeEvent : TimerEvent) : Void {
		screen.rotation = 0;
		shakeState = Origin;
	}
	
	public function startAnimation(screen : Sprite) {
		this.screen = screen;
		shakeTimer.start();
	}
	
}