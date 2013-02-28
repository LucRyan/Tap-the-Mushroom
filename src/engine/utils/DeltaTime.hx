package engine.utils;
import nme.utils.Timer;
import nme.events.TimerEvent;

/**
 * ...
 * @author Yang Wang
 */

class DeltaTime 
{

	// Use for singleton.
	public static var DELTA_TIME = new DeltaTime();
	
	/**
	 * Singleton function
	 * @return
	 */
	public function getInstance() : DeltaTime{
		if ( DELTA_TIME == null) {
			DELTA_TIME = new DeltaTime();
		}
		return DELTA_TIME;
	}
	
	private function new() 
	{
		TIMECOUNT = 0;
	}
	
	public static var TIMECOUNT : Int;
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
		TIMECOUNT += 1;
	}
	
	
}