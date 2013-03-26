package game.level;
import engine.scene.BaseScene;
import game.common.utils.ButtonAdder;
import nme.events.Event;

/**
 * ...
 * @author Yang Wang
 */
class LevelContainer extends BaseScene
{

	var buttonAdder : ButtonAdder;
	public function new() 
	{
		super();	
		addEventListener (Event.ENTER_FRAME, this_onEnterFrame);
	}
	
	/**
	 * Override the construct which will load the stage when the level start.
	 */
	override private function construct () {
		buttonAdder = new ButtonAdder();
		loadBackground("img/background.jpg");
		resize ();
		addBasicObjects();
		
		//Handle resize
		stage.addEventListener(Event.RESIZE, stage_onResize);
	}
	
	// TODO: THIS FUNCTION NEED REFACTOR!!!!
	private function addBasicObjects() : Void {
		addChild(background);
		buttonAdder.addButtons(this);
	}
	
	override private function resize () {
		buttonAdder.resizeButtons();
		resizeBackground();
	}
	
	
}