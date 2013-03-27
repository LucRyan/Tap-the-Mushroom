package game.levelmenu.utils;
import engine.objects.SceneObject;
import nme.events.TimerEvent;
import engine.utils.MTimer;

/**
 * ...
 * @author Yang Wang
 */
class PageIcon extends SceneObject
{

	public function new(?setPageFlag : Bool) 
	{
		super();
		loadMovieClip("TaptheMushroom:tm.PageIcon");
		if (setPageFlag) {
			setPage();
		}else {
			MTimer.TIMER.getInstance().wait(90, stopIcon); // Use Timer just for fixing bug
		}
		
	}

	private function stopIcon(event:TimerEvent) :Void {
		objectClip.gotoAndStop(2);
	}
	
	public function setPage() : Void{
		objectClip.gotoAndStop(6);
	}
	
	public function unsetPage() : Void{
		objectClip.gotoAndStop(2);
	}
}