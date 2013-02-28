package game.common.utils;
import game.tap.mushroom.Mushroom;

/**
 * ...
 * @author Yang Wang
 */

class ScoreSystem 
{

	// Use for singleton.
	public static var SCORE_SYSTEM = new ScoreSystem();
	
	/**
	 * Singleton function
	 * @return
	 */
	public function getInstance() : ScoreSystem{
		if ( SCORE_SYSTEM == null) {
			SCORE_SYSTEM = new ScoreSystem();
		}
		return SCORE_SYSTEM;
	}
	
	public function new() 
	{
		
	}
	
	var scoreCount : Int;
	
	public function checkScoreTEM(mushroomPool : Array<Mushroom>) {
		scoreCount = 0;
		for (i in 0 ... 40) {
			if (!mushroomPool[i].objectClip.visible) scoreCount += 1;
		}
	}
	
	public function getScore() : Int {
		return scoreCount;
	}
	
	
}