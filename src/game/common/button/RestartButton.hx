package game.common.button;
import engine.objects.Button;
import nme.events.MouseEvent;
import game.common.scene.LevelManager;
import engine.sound.SoundSystem;

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
	}
	
	
	
	override public function mouseClick(mouseEvent : MouseEvent) {
		SoundSystem.SOUND_SYSTEM.getInstance().playSoundFx("RestartButton", 1);
		LevelManager.LEVEL_MANAGER.getInstance().startFadeOut();
		
	}
	
	override private function mouseDown(mouseEvent : MouseEvent) {objectClip.gotoAndStop(6);}
	
	override private function mouseUp(mouseEvent : MouseEvent) {objectClip.gotoAndStop(8);}
	
	override private function mouseOver(mouseEvent : MouseEvent) {objectClip.gotoAndStop(4);}
	
	override private function mouseOut(mouseEvent : MouseEvent) { objectClip.gotoAndStop(2); }
	
}