package engine.objects;
import format.display.MovieClip;
import nme.Lib;
import nme.media.Sound;
import nme.Assets;

/**
 * ...
 * @author Yang Wang
 */

class Button extends TouchableObject
{

	var clickSound : Sound;
	
	public function new() 
	{
		super();
	}
	
	private function loadSound(soundPath : String) : Void {
		clickSound =  Assets.getSound (soundPath);
	}
	
	
}