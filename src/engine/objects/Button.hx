package engine.objects;
import format.display.MovieClip;
import nme.Lib;
import nme.media.Sound;
import nme.Assets;
import nme.events.MouseEvent;

/**
 * ...
 * @author Yang Wang
 */

class Button extends TouchableObject
{
	
	public function new() 
	{
		super();
	}
	
	override private function mouseDown(mouseEvent : MouseEvent) {objectClip.gotoAndStop(6);}
	
	override private function mouseUp(mouseEvent : MouseEvent) {objectClip.gotoAndStop(8);}
	
	override private function mouseOver(mouseEvent : MouseEvent) {objectClip.gotoAndStop(4);}
	
	override private function mouseOut(mouseEvent : MouseEvent) { objectClip.gotoAndStop(2); }
	
}