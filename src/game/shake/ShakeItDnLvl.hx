package game.shake;
import engine.objects.SceneObject;
import engine.physics.PhysicsObject;
import engine.physics.PhysicsScene;
import format.display.MovieClip;
import nme.display.Sprite;
import box2D.collision.shapes.B2CircleShape;
import box2D.collision.shapes.B2PolygonShape;
import box2D.common.math.B2Vec2;
import box2D.dynamics.B2Body;
import box2D.dynamics.B2BodyDef;
import box2D.dynamics.B2DebugDraw;
import box2D.dynamics.B2FixtureDef;
import box2D.dynamics.B2World;
import nme.events.Event;
import nme.Assets;
import nme.Lib;
import nme.display.Bitmap;

/**
 * ...
 * @author Yang Wang
 */
class ShakeItDnLvl extends PhysicsScene
{
	var mushroom : PhysicsObject;
	var wall : PhysicsObject;
	
	public function new() 
	{
		super();
		initialWorld(new B2Vec2(0, 10.0));
		addEventListener (Event.ENTER_FRAME, this_onEnterFrame);
	}
	
	override private function construct ():Void {
		
		mushroom = new PhysicsObject(); 
		mushroom.createBody(world, 188, 155, 4, 350, 100, true);
		mushroom.setFixtureDef(1.0, 0.3);
		wall = new PhysicsObject();
		wall.createBody(world, 188, 155, 3, 300, 400, false);
		
		addEventListener (Event.ENTER_FRAME, this_onEnterFrame);
	}
	
	// Event Handlers
	
	override private function update (?deltaTime : Float) : Void {
		world.step (1 / 30, 10, 10);
		world.clearForces ();
		//world.drawDebugData ();
		mushroom.tick();
		wall.tick();
	}
	
	
	
	
}