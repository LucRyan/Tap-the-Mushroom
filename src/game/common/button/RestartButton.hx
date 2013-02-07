package game.common.button;
import engine.objects.Button;
import nme.events.MouseEvent;

/**
 * ...
 * @author Yang Wang
 */

class RestartButton extends Button
{


	public function new() 
	{
		super();
		loadMovieClip("TaptheMushroom:tm.RestartButton");
		objectClip.gotoAndStop(2);
		addListener();
		loadSound("sound/RestartButton.wav");
	}
	
	
	
	override private function mouseClick(mouseEvent : MouseEvent) {
		clickSound.play(0, 1);
	}
	
	override private function mouseDown(mouseEvent : MouseEvent) {objectClip.gotoAndStop(6);}
	
	override private function mouseUp(mouseEvent : MouseEvent) {objectClip.gotoAndStop(8);}
	
	override private function mouseOver(mouseEvent : MouseEvent) {objectClip.gotoAndStop(4);}
	
	override private function mouseOut(mouseEvent : MouseEvent) { objectClip.gotoAndStop(2); }
	
}