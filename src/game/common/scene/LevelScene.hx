package game.common.scene;
import engine.scene.BaseScene;
import game.common.displayItem.CountDownTimer;
import nme.Assets;

/**
 * ...
 * @author Yang Wang
 */

class LevelScene extends BaseScene
{

	public function new() 
	{
		super();
	}
	

	var countDownTimer : CountDownTimer; // Count Down Timer's background.
	
	private function addBasicObjects() : Void {
		addChild(background);
	}
}