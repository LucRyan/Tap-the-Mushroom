package engine.sound;
import nme.media.Sound;
import nme.Assets;
import nme.media.SoundChannel;

/**
 * ...
 * @author Yang Wang
 */

class SoundSystem 
{
	var backgroundMusic : Sound;
	var backgroundMusicChannel : SoundChannel;
	var soundEffect : Sound;
	var soundEffectChannel : SoundChannel;
	
	
	// Use for singleton.
	public static var SOUND_SYSTEM = new SoundSystem();
	
	/**
	 * Singleton function
	 * @return
	 */
	public function getInstance() : SoundSystem{
		if ( SOUND_SYSTEM == null) {
			SOUND_SYSTEM = new SoundSystem();
		}
		return SOUND_SYSTEM;
	}
	
	
	public function new() 
	{
		
	}
	
	public function playBackgroundMusic(?soundPath : String) : Void {
		backgroundMusic = Assets.getSound ((soundPath == null)? "sound/LevelBackground.wav" : soundPath);
		#if flash
		backgroundMusicChannel = backgroundMusic.play(0, 1000); // Flash API doesn't support -1 as infinite.
		#elseif android
		backgroundMusicChannel = backgroundMusic.play(0, -1);
		#end
	}
	
	public function stopBackgroundMusic() : Void {
		backgroundMusicChannel.stop();
	}
	
	public function playSoundEffect(?soundPath : String) : Void {
		soundEffect = Assets.getSound ((soundPath == null)? "sound/MenuButton.mp3" : soundPath);
		soundEffectChannel = soundEffect.play(0, 1);
	}
	
	
	
	
}