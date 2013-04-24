package game.levelmenu;
import engine.objects.Button;
import engine.scene.BaseScene;
import game.levelmenu.levels.LvlWelcome;
import nme.events.Event;

/**
 * ...
 * @author Yang Wang
 */
class Welcome extends BaseScene
{
	var welcomButton : LvlWelcome;
	// Constructor 
	public function new () {	
		super();
	}
	
	override public function delete() {
		super.delete();
		super.removeChild(background);
		this.removeEventListener(Event.RESIZE, stage_onResize, true);
	}
	
	override private function construct () {
		initialObjects();
		//Add the Sprite to stage.
		resize ();
		addBasicObjects();

		
		//Handle resize
		stage.addEventListener(Event.RESIZE, stage_onResize);
	}
	
	private function initialObjects() :Void {
		welcomButton = new LvlWelcome();
		loadBackground("img/background.jpg");
	}
	
		
	private function addBasicObjects() : Void {
		addChild(background);
		addChild(welcomButton.objectClip);
	}
	
	override private function resize () {
		super.resize();
		welcomButton.resizeMovieClip(welcomButton.objectClip, 800, 480, 1, 1/2, 1/2);
	}
}