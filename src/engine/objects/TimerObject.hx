package engine.objects;

/**
 * ...
 * @author Yang Wang
 */

class TimerObject extends TextObject
{

	var timeCount : Float;
	var _totalTime : Float;
	var countTimer : Timer;
	
	public function new() 
	{
		
	}
	
	private function initialTimer(totalTime : Float) {
		_totalTime = totalTime;
	}
	
}