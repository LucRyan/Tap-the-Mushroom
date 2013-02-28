package game.common.button;
import engine.objects.Button;
import nme.Assets;
import nme.Lib;
import nme.events.MouseEvent;

/**
 * ...
 * @author Yang Wang
 */

class MenuButton extends Button
{

	public function new() 
	{
		super();
		loadMovieClip("TaptheMushroom:tm.MenuButton");
		objectClip.gotoAndStop(2);
		addListener();
		loadSound("sound/MenuButton.mp3");
	}
	
	
	
	override public function mouseClick(mouseEvent : MouseEvent) {
		clickSound.play(0, 1);
	}
	
	override private function mouseDown(mouseEvent : MouseEvent) {objectClip.gotoAndStop(6);}
	
	override private function mouseUp(mouseEvent : MouseEvent) {objectClip.gotoAndStop(8);}
	
	override private function mouseOver(mouseEvent : MouseEvent) {objectClip.gotoAndStop(4);}
	
	override private function mouseOut(mouseEvent : MouseEvent) { objectClip.gotoAndStop(2); }
	
/*	override public function resizeObject(originWidth : Int, originHeight : Int, sizeLvl : Int, positionX : Int, postionY : Int) : Void {
		//Size
		var scaleWidth = Lib.current.stage.stageWidth / 10; // margin is width/10, and the scale offset is width/40.
		var scaleHeight = scaleWidth / 527 * 132; // Scale the height with Image ratio.
		objectClip.height = scaleHeight;
		objectClip.width = scaleWidth;
		objectClip.alpha = 1.0;
		//Position
		objectClip.x = Lib.current.stage.stageWidth / 13;
		objectClip.y = Lib.current.stage.stageHeight / 18 * 17;
	}*/
	
}