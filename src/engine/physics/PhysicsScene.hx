package engine.physics;
import engine.scene.BaseScene;
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

/**
 * ...
 * @author Yang Wang
 */
class PhysicsScene extends BaseScene
{
	public static var PHYSICS_SCALE : Float = 1 / 30;
	private var physicsDebug:Sprite;
	private var world:B2World;
	
	public function new() 
	{
		super();
	}
	
	/**
	 * Set the World
	 */
	private function initialWorld(gravity : B2Vec2):Void {
		//
		world = new B2World (gravity, true);
		physicsDebug = new Sprite ();
		//
		var debugDraw = new B2DebugDraw ();
		debugDraw.setSprite (physicsDebug);
		debugDraw.setDrawScale (1 / PHYSICS_SCALE);
		debugDraw.setFlags (B2DebugDraw.e_shapeBit);
		//
		world.setDebugDraw (debugDraw);
		addChild (physicsDebug);
	}
}