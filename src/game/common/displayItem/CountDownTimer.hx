package game.common.displayItem;
import engine.objects.TextObject;
import nme.text.Font;
import nme.text.TextField;
import nme.text.TextFormat;
import nme.text.TextFieldAutoSize;
import nme.Assets;
import nme.utils.Timer;
import nme.events.TimerEvent;

/**
 * ...
 * @author Yang Wang
 */

class CountDownTimer extends TextObject
{
	var timeCount : Float;
	var totalTime = 5000;
	var countTimer : Timer;
	var textContent : String;
	
	public function new() 
	{
		super();
		loadMovieClip("TaptheMushroom:tm.CountDownTimer");
		objectClip.gotoAndStop(2);
	}
	 
	override private function initialize(?font : String) {
		 displayText = new TextField();
		 customFont = Assets.getFont("fonts/SceneFonts.ttf");
		 fontFmt = new TextFormat(customFont.fontName);
		 timeCount = totalTime;
		 countTimer = new Timer(10, Std.int(totalTime/10));
		 countTimer.addEventListener(TimerEvent.TIMER, updateTimer, false, 0, false);
		 textContent = Std.string(timeCount).substr(0, 1) + "." + Std.string(timeCount).substr(1, 4);
	 }
	 
	 
	 public function startCount() {
		 if(!countTimer.running){
			countTimer.start();
		 }
	 }
	 
	 public function stopCount() {
		 countTimer.stop();
	 }
	 
	 public function setCompleteEvent(func : Dynamic) {
		 countTimer.addEventListener(TimerEvent.TIMER_COMPLETE, func, false, 0, false);
	 }
	 
	 public function getTextContent() : String {
		 return textContent;
	 }
	 
	 private function updateTimer(event: TimerEvent) : Void {
		 timeCount -= 10;
		 textContent = Std.string(timeCount).substr(0, 1) + "." + Std.string(timeCount).substr(1, 4);
		 displayText.text = textContent;
	 }
	 
	 

	
}