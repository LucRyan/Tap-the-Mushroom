package game.tap.mushroom;
import format.display.MovieClip;

/**
 * ...
 * @author Yang Wang
 */

 /**
  * Dependency Injection
  */
interface IMushroom 
{
	var mushClip : MovieClip;
	
	public function setObjectClip( movieClip : MovieClip ) : Void;
	public function startJump() : Void;
	public function stopJump() : Void;
}