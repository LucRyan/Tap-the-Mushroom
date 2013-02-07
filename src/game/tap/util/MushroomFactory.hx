package game.tap.util;
import game.tap.mushroom.IMushroom;
import game.tap.mushroom.BlueMushroom;
import game.tap.mushroom.GreenMushroom;
import game.tap.mushroom.RedMushroom;
import game.tap.mushroom.PurpleMushroom;
import game.tap.mushroom.GreenBlueMushroom;
import game.tap.mushroom.YellowMushroom;

/**
 * ...
 * @author Yang Wang
 */

enum MushroomColor {
	Red ;
	Green ;
	Blue ;
	GreenBlue ;
	Yellow ;
	Purple ;
	None;
}
 
// Simple DI Method

class MushroomFactory
{

	public function new() 
	{
		
	}
	
	// Use for singleton.
	public static var MUSHROOM_FACTORY = new MushroomFactory();
	
	/**
	 * Singleton function
	 * @return
	 */
	public function getInstance() : MushroomFactory{
		if ( MUSHROOM_FACTORY == null) {
			MUSHROOM_FACTORY = new MushroomFactory();
		}
		return MUSHROOM_FACTORY;
	}
	
	public function createMushroom(color : MushroomColor, index : Int ): IMushroom {
		if (color != None){
			switch(color) {
				case Red:
					return new RedMushroom();
				case Green:
					return new GreenMushroom();
				case Blue:
					return new BlueMushroom();
				case GreenBlue:
					return new GreenBlueMushroom();
				case Yellow:
					return new YellowMushroom();
				case Purple:
					return new PurpleMushroom();
				default:
					return null;	
			}
		}else {
			switch(index) {
				case 0:
					return new RedMushroom();
				case 1:
					return new GreenMushroom();
				case 2:
					return new BlueMushroom();
				case 3:
					return new GreenBlueMushroom();
				case 4:
					return new YellowMushroom();
				case 5:
					return new PurpleMushroom();
				default:
					return null;	
			}
		}
		
	}
	
	
}