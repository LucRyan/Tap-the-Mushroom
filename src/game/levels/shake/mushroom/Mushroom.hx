package game.levels.shake.mushroom;
import engine.physics.PhysicsObject;
import engine.scene.BaseScene;
import format.display.MovieClip;
import nme.Assets;
import nme.Lib;

/**
 * ...
 * @author Yang Wang
 */
class Mushroom extends PhysicsObject
{
	public var shadow : MovieClip;
	var shadowOriginWidth : Float;
	var screenWidth : Int;

	public function new() 
	{
		super();	
		initialShadow();
	}
	
	private function initialShadow() {
		shadow = Assets.getMovieClip("TaptheMushroom:tm.ShakeShadow");
		resizeMovieClip(shadow, 133, 22, 4, 400/800, 465/480);	
		shadowOriginWidth = Lib.current.stage.stageWidth / 30 * 4;
		screenWidth = Lib.current.stage.stageHeight;
		
	}

	override public function tick(?deltaTime:Float = 1.0):Dynamic 
	{
		super.tick();
		shadow.x = objectClip.x;
		shadow.width = shadowOriginWidth * (objectClip.y / ( (465 / 480) * screenWidth) ); // 465/480 is the margin for shadow.
		shadow.height = shadow.width * 22 / 133;
	}
	
}