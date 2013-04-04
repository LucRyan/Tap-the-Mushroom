package game.common.displayItem;
import engine.objects.TextObject;
import engine.utils.ITickable;
import nme.text.Font;
import nme.text.TextField;
import nme.text.TextFormat;
import nme.text.TextFieldAutoSize;
import nme.Assets;
import nme.utils.Timer;
import nme.events.TimerEvent;
import nme.Lib;

/**
 * ...
 * @author Yang Wang
 */

class CountDownTimer extends TextObject, implements ITickable
{
	var countTimer : Timer;
	var textContent : String;
	//
	var timeCount : Float;
	var totalTime : Int = 5000;
	var startStamp : Int;
	var runningFlag : Bool = false;
	var completeFlag : Bool = false;
	
	public function new(?totalTime : Int = 5000) 
	{
		this.totalTime = totalTime;
		super();
		loadMovieClip("TaptheMushroom:tm.CountDownTimer");
		objectClip.gotoAndStop(2);
	}
	
	override public function delete() : Void 
	{
		super.delete();
		stopCount();
	}
	
	public function tick(?deltaTime : Float) 
	{
		if (runningFlag)
		{
			if (totalTime > Lib.getTimer() - startStamp ){
				updateTimer();
			}else {
				completeFlag = true;
				runningFlag = false;
				timeCount = 0;
				displayText.text = "0.000";
			}
		}
	}
	 
	override private function initialize(?font : String) {
		 displayText = new TextField();
		 customFont = Assets.getFont("fonts/SceneFonts.ttf");
		 fontFmt = new TextFormat(customFont.fontName);
		 timeCount = totalTime;
		 if(totalTime >= 10000){
			textContent = Std.string(timeCount).substr(0, 2) + "." + Std.string(timeCount).substr(2, 2);
		 }else {
			textContent = Std.string(timeCount).substr(0, 1) + "." + Std.string(timeCount).substr(1, 3);
		 }
	 }
	 
	 /**
	  * Call this function to start count.
	  */
	 public function startCount() {
		 if (!runningFlag) {
			 runningFlag = true;
			 completeFlag = false;
			 startStamp = Lib.getTimer();
		 }
	 }
	 
	 /**
	  * Determine the timer is completed.
	  * @return the flag use for update complete function.
	  */
	 public function isComplete() : Bool{
		 return completeFlag;
	 }
	 
	 /**
	  * After complete, we need set the completeFlag to false
	  */
	 public function resetComplete() {
		 completeFlag = false;
	 }
	 
	 public function stopCount() {
		 completeFlag = false;
		 runningFlag = false;
	 }
	 
	 public function getTextContent() : String {
		 return textContent;
	 }
	 
	 private function updateTimer(?digit: Int = 3) : Void {
		 //TODO: FPS is 30, therefore the time difference is 1000/30.
		 //Possible Answer: Sometime the Stage will freaze but the timer won't.
		 timeCount -= 1000/30; // I don't know why, when set 1000/30, there always some count left when it complete.
		
		 //if total time greater than 10000, the timer need a different display.
		 if(timeCount >= 10000){
			textContent = Std.string(timeCount).substr(0, 2) + "." + Std.string(timeCount).substr(2, 2);
		 }else {
			textContent = Std.string(timeCount).substr(0, 1) + "." + Std.string(timeCount).substr(1, 3);
		 }
		 
		 //Handler the situation when timecount less than 1000.
		 if(timeCount > 100 && timeCount <= 1000){
			textContent = "0." + Std.string(timeCount).substr(0, 3);
		 }else if (timeCount > 10 && timeCount <= 100) {
			textContent = "0.0" + Std.string(timeCount).substr(0, 3);
		 }else if (timeCount > 0 && timeCount <= 10) {
			 textContent = "0.00" + Std.string(timeCount).substr(0, 2);
		 }
		 
		 //At the end, may have some bugs.
		 if (timeCount <= 0) {
			 timeCount = 0;
			 displayText.text = "0.000";
		 }else {
			 displayText.text = textContent;
		 }
		 
	 }
	 
	 

	
}