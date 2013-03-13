package engine.utils;
import nme.utils.Timer;
import nme.events.TimerEvent;

/**
 * ...
 * @author Yang Wang
 */

class MTimer 
{

	// Use for singleton.
	public static var TIMER = new MTimer();
	
	/**
	 * Singleton function
	 * @return
	 */
	public function getInstance() : MTimer{
		if ( TIMER == null) {
			TIMER = new MTimer();
		}
		return TIMER;
	}
	
	private function new() 
	{
		timeCount = 0;
	}
	
	public static var timeCount : Int;
	var timer : Timer;
	var waitTimer : Timer;
	
	/**
	 * 
	 * @param	?updateFunc
	 */
	public function initializeTimer(?updateFunc : Dynamic) {
		timer = new Timer(1000 / 30, 0);
		if (timer.running) timer.stop();
		timer.addEventListener(TimerEvent.TIMER, ((updateFunc == null)? update : updateFunc), false, 0, false);
		timer.start();
	}
	
	/**
	 * 
	 */
	public function wait(ms : Float, func : Dynamic ) : Void {
		waitTimer = new Timer (ms, 1);
		if (waitTimer.running) waitTimer.stop();
		waitTimer.addEventListener(TimerEvent.TIMER_COMPLETE, func, false, 0, false);
		waitTimer.start();
	}
	
	private function update(event : TimerEvent) : Void {
		timeCount += 1;
	}
	
	
}