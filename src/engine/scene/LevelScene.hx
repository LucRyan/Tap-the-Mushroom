package engine.scene;
import game.common.button.MenuButton;
import game.common.button.RestartButton;
import game.common.displayItem.CountDownTimer;
import nme.media.Sound;
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
		initializeButtons();
		playBackgroundMusic();
	}
	
	var menuButton : MenuButton; // The Button link to menu.
	var restartButton : RestartButton; // The Button to reload level.
	var countDownTimer : CountDownTimer; // Count Down Timer's background.
	var backgroundMusic : Sound;
	
	private function playBackgroundMusic() : Void {
		backgroundMusic = Assets.getSound ("sound/LevelBackground.wav");
		#if flash
		backgroundMusic.play(0, 1000); // Flash API doesn't support -1 as infinite.
		#else if android
		backgroundMusic.play(0, -1);
		#end
	}
	
	private function initializeButtons() : Void{
		menuButton = new MenuButton();
		restartButton = new RestartButton();
		countDownTimer = new CountDownTimer();
	}
	
	private function resizeButtons() : Void {
		menuButton.resizeMovieClip(menuButton.objectClip, 527, 132, 9, 1.0 / 13.0, 17.0 / 18.0);
		restartButton.resizeMovieClip(restartButton.objectClip, 231, 184, 22, 17.0 / 18.0, 17.0 / 18.0); 
	}
	
	private function addBasicObjects() : Void {
		addChild(background);
		addChild(menuButton.objectClip);
		addChild(restartButton.objectClip);
	}
}