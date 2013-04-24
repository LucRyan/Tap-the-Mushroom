package game.levelmenu.levels;
import engine.objects.Button;
import game.common.scene.LevelManager;
import nme.events.MouseEvent;
import engine.sound.SoundSystem;
import engine.utils.MTimer;
import nme.events.TimerEvent;

/**
 * ...
 * @author Yang Wang
 */
class LvlWelcome extends Button
{

	public function new() 
	{
		super();
		loadMovieClip("TaptheMushroom:tm.Welcome");
		MTimer.TIMER.getInstance().wait(200, stopIcon); // Use Timer just for fixing bug.
		addListener();
	}
	
	override public function mouseClick(mouseEvent : MouseEvent) {
		SoundSystem.getInstance().playSoundFx("Button", 1);
		LevelManager.getInstance().changePages(LevelSel);
	}
	
	private function stopIcon(event:TimerEvent) :Void {
		objectClip.gotoAndStop(2);
	}
}