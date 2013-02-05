package tap.mushroom;


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
 
// Simple Factory Method

class MushroomFactory
{

	public function new() 
	{
		
	}
	
	public function createMushroom(color : MushroomColor, index : Int ): Mushroom {
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