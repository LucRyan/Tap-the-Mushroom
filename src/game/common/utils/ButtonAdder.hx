package game.common.utils;
import engine.objects.TextObject;
import game.common.button.MenuButton;
import game.common.button.RestartButton;
import nme.display.Sprite;

/**
 * ...
 * @author Yang Wang
 */

class ButtonAdder 
{

	var menuButton : MenuButton; // The Button link to menu.
	var restartButton : RestartButton; // The Button to reload level.
	var timerDisplay : TextObject;
	
	public function new() 
	{
		initializeButtons();
	}
	
	private function initializeButtons() : Void{
		menuButton = new MenuButton();
		restartButton = new RestartButton();
	}
	
	
	public function resizeButtons() : Void {
		menuButton.resizeMovieClip(menuButton.objectClip, 527, 132, 9, 1.0 / 13.0, 17.0 / 18.0);
		restartButton.resizeMovieClip(restartButton.objectClip, 231, 184, 22, 17.0 / 18.0, 17.0 / 18.0); 
	}
	
	public function addButtons(stage : Sprite) {
		resizeButtons();
		stage.addChild(menuButton.objectClip);
		stage.addChild(restartButton.objectClip);
	}

}