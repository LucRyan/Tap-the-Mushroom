package game.levelmenu.levels;
import engine.objects.Button;
import nme.events.MouseEvent;
import engine.sound.SoundSystem;
import engine.utils.MTimer;
import nme.events.TimerEvent;
/**
 * ...
 * @author Yang Wang
 */
class LvlComing extends Button
{

	public function new() 
	{
		super();
		loadMovieClip("TaptheMushroom:tm.LevelComing");
		//loadMovieClip("TaptheMushroom:tm.LevelTap");
		MTimer.TIMER.getInstance().wait(60, stopIcon); // Use Timer just for fixing bug
		addListener();
	}
	
	override public function mouseClick(mouseEvent : MouseEvent) {
		SoundSystem.SOUND_SYSTEM.getInstance().playSoundFx("MenuButton", 1);
	}
	
		
	private function stopIcon(event:TimerEvent) :Void {
		objectClip.gotoAndStop(2);
	}
	
	
}