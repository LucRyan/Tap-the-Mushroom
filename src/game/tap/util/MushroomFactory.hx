package game.tap.util;
import game.tap.mushroom.Mushroom;


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
	
	public function createMushroom(color : MushroomColor, index : Int ): Mushroom {
		if (color != None){
			switch(color) {
				case Red:
					return new Mushroom("TaptheMushroom:tm.RedMushroomJump");
				case Green:
					return new Mushroom("TaptheMushroom:tm.GreenMushroomJump");
				case Blue:
					return new Mushroom("TaptheMushroom:tm.BlueMushroomJump");
				case GreenBlue:
					return new Mushroom("TaptheMushroom:tm.GreenBlueMushroomJump");
				case Yellow:
					return new Mushroom("TaptheMushroom:tm.YellowMushroomJump");
				case Purple:
					return new Mushroom("TaptheMushroom:tm.PurpleMushroomJump");
				default:
					return null;	
			}
		}else {
			switch(index) {
				case 0:
					return new Mushroom("TaptheMushroom:tm.RedMushroomJump");
				case 1:
					return new Mushroom("TaptheMushroom:tm.GreenMushroomJump");
				case 2:
					return new Mushroom("TaptheMushroom:tm.BlueMushroomJump");
				case 3:
					return new Mushroom("TaptheMushroom:tm.GreenBlueMushroomJump");
				case 4:
					return new Mushroom("TaptheMushroom:tm.YellowMushroomJump");
				case 5:
					return new Mushroom("TaptheMushroom:tm.PurpleMushroomJump");
				default:
					return null;	
			}
		}
		
	}
	
	
}