package game.tap.util;

import format.display.MovieClip;
import nme.display.Bitmap;
import nme.display.Sprite;
import nme.display.StageAlign;
import nme.display.StageScaleMode;
import nme.events.Event;
import nme.Assets;
import nme.Lib;


import game.tap.util.MushroomFactory;
import game.tap.mushroom.IMushroom;

/**
 * ...
 * @author Yang Wang
 */

class MushroomPlanter
{

	var mushroomPool : Array<IMushroom>;
	var muFactory : MushroomFactory;
	
	
	public function new() 
	{
		muFactory = MushroomFactory.MUSHROOM_FACTORY.getInstance();
		mushroomPool = new Array<IMushroom>();
	}


	/**
	 * Function will resize 40 mushroom on a current stage.
	 * If you want change the numbers of total mushrooms, cols and rows, you should change the params.
	 * 
	 * @param	mushroom the sceneObject, interface.
	 * @param	index the index of mushrooms
	 * @param	rows the rows of mushrooms you want on the stage
	 * @param	cols  the cols of mushrooms you want on the stage
	 * @param	rowOffset make sure half in the top and half in the bottom
	 * @param	colOffset make sure half in the left and half in the right
	 */
	public function resizeMushroom (mushroom : IMushroom, index : Int, rows : Int, cols : Int, rowOffset : Float, colOffset : Float ) : Void {
		//Size
		var scaleWidth = ((Lib.current.stage.stageWidth  - Lib.current.stage.stageWidth/10) / 8 - Lib.current.stage.stageWidth / 25 ); // margin is width/10, and the scale offset is width/40.
		var scaleHeight = scaleWidth / 188 * 155; // Scale the height with Image ratio.
		mushroom.mushClip.height = scaleHeight;
		mushroom.mushClip.width = scaleWidth;
		mushroom.mushClip.alpha = 1.0;
		//Position
		mushroom.mushClip.x = (Lib.current.stage.stageWidth + mushroom.mushClip.width) / 2 + (index % cols - colOffset ) * Lib.current.stage.stageWidth/10;
		mushroom.mushClip.y = (Lib.current.stage.stageHeight + mushroom.mushClip.height) / 2 + (index % rows - rowOffset ) * Lib.current.stage.stageHeight/8 ;
	}
	
	/**
	 * Function will create 40 random mushrooms.
	 * @return the mushroomPool which contains 40 random mushrooms.
	 */
	public function plantMushrooms() : Array<IMushroom>{
		for (i in 0 ... 40) {
			var tempMush : IMushroom = muFactory.createMushroom(None, Std.int( Math.random() * 6));
			resizeMushroom(tempMush, i, 5, 8, 2.2, 4);
			mushroomPool.push(tempMush);
		}
		
		return mushroomPool;
	}
	
}