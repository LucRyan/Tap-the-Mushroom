package engine.sound;
import nme.media.Sound;
import nme.Assets;
import nme.media.SoundChannel;
import nme.media.SoundTransform;

/**
 * ...
 * @author Yang Wang
 */

class SoundSystem 
{
	var backgroundMusic : Sound;
	var backgroundMusicChannel : SoundChannel;
	var soundFx : Sound;
	var soundFxChannel : SoundChannel;
	var soundFxTransform : SoundTransform;
	var soundPool : Hash<Sound>;
	var soundChannelPool : Hash<SoundChannel>;
	var initialFlag : Bool = false;
	
	
	// Use for singleton.
	private static var SOUND_SYSTEM : SoundSystem = new SoundSystem();
	
	/**
	 * Singleton function
	 * @return
	 */
	public static function getInstance() : SoundSystem{
		if ( SOUND_SYSTEM == null) {
			SOUND_SYSTEM = new SoundSystem();
		}
		return SOUND_SYSTEM;
	}
	
	
	private function new() 
	{
		
	}
	
	//Add all sound need to play
	private function initialSoundSystem() : Void {
		soundPool = new Hash<Sound>();
		soundChannelPool = new Hash<SoundChannel>();
		loadSound("LevelBackground", "wav");
		loadSound("Stars", "mp3");
		loadSound("MushroomJump", "mp3");
		loadSound("PokeMushroom", "wav");
		loadSound("Button", "wav");
	}
	
	private function loadSound( name : String, format : String) : Void {
		soundFx = Assets.getSound ("sound/" + name + "." + format);
		soundPool.set(name, soundFx);
	}
	
	public function playSoundFx(key : String, ?loop : Int = 1) : Void {
		if (initialFlag == false) {
			initialSoundSystem();
			initialFlag = true;
		}
		if (soundPool.get(key).isBuffering && soundChannelPool.exists(key))
			soundChannelPool.get(key).stop();
		soundFxChannel = soundPool.get(key).play(0, loop);
		soundChannelPool.set(key, soundFxChannel);
	}
	
	public function stopSoundFx(key : String) : Void {
		if (soundChannelPool.exists(key)) soundChannelPool.get(key).stop();
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

}