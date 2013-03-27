package game.common.button;
import engine.objects.Button;
import nme.Assets;
import nme.Lib;
import nme.events.MouseEvent;
import engine.sound.SoundSystem;
import game.common.scene.LevelManager;

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
	}
	
	override public function mouseClick(mouseEvent : MouseEvent) {
		SoundSystem.SOUND_SYSTEM.getInstance().playSoundFx("Button", 1);
		LevelManager.LEVEL_MANAGER.getInstance().changePages(LevelSel);
	}
	
}