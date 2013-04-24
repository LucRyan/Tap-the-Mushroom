package game.levels.shake.utils;

/**
 * ...
 * @author Yang Wang
 */

class WallStateGenerator
{
	private var bottomActive : Bool = false;
	private var upperActive : Bool = true; // for the first time
	private var leftActive : Bool = false;
	private var rightActive : Bool = false;

	
	public function new() 
	{
		
	}
	
	public function isActive(wallName : String) : Bool {
		switch(wallName) {
			case "Bottom" :
				return bottomActive;
			case "Upper" :
				return upperActive;
			case "Left" :
				return leftActive;
			case "Right" :
				return rightActive;
			default:
				return false;
		}
	}
	
	public function afterHit(wallName : String) : Void {
		switch(wallName) {
			case "Bottom" :
				bottomActive = false;
			case "Upper" :
				upperActive = false;
			case "Left" :
				leftActive = false;
			case "Right" :
				rightActive = false;
			default:
				bottomActive = false;
				upperActive = false;
				leftActive = false;
				rightActive = false;
		}
	}
	
	public function genWallState() : Void {
		switch(Std.int(Math.random() * 4.0)){
			case 0:
				bottomActive = true;
				upperActive = false;
				leftActive = false;
				rightActive = false;
			case 1:
				bottomActive = false;
				upperActive = true;
				leftActive = false;
				rightActive = false;
			case 2:
				bottomActive = false;
				upperActive = false;
				leftActive = true;
				rightActive = false;
			case 3:
				bottomActive = false;
				upperActive = false;
				leftActive = false;
				rightActive = true;
			default: 
				bottomActive = false;
				upperActive = false;
				leftActive = false;
				rightActive = false;	
		}
		
	}
	
}