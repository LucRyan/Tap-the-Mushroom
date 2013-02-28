package engine.utils;
import engine.objects.SceneObject;

/**
 * ...
 * @author Yang Wang
 */

class LayoutManager 
{

	public function new() 
	{
		
	}
	
	public function layoutObject (sceneObj : SceneObject, index : Int, rows : Int, cols : Int, rowOffset : Float, colOffset : Float ) : Void {
		//Size
		var scaleWidth = ((Lib.current.stage.stageWidth  - Lib.current.stage.stageWidth/10) / 8 - Lib.current.stage.stageWidth / 25 ); // margin is width/10, and the scale offset is width/40.
		var scaleHeight = scaleWidth / 188 * 155; // Scale the height with Image ratio.
		sceneObj.objectClip.height = scaleHeight;
		sceneObj.objectClip.width = scaleWidth;
		sceneObj.objectClip.alpha = 1.0;
		//Position
		sceneObj.objectClip.x = (Lib.current.stage.stageWidth + sceneObj.objectClip.width) / 2 + (index % cols - colOffset ) * Lib.current.stage.stageWidth/10;
		sceneObj.objectClip.y = (Lib.current.stage.stageHeight + sceneObj.objectClip.height) / 2 + (index % rows - rowOffset ) * Lib.current.stage.stageHeight/8 ;
	}
	
}