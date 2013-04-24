package game.common.utils;
import game.levels.tap.mushroom.Mushroom;

/**
 * ...
 * @author Yang Wang
 */

class ScoreSystem 
{

	// Use for singleton.
	private static var SCORE_SYSTEM = new ScoreSystem();
	
	/**
	 * Singleton function
	 * @return
	 */
	public static function getInstance() : ScoreSystem{
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
	
	public function checkScoreSKT(score : Int) {
		scoreCount = score;
	}
	
	public function getScore() : Int {
		return scoreCount;
	}
	
	
}