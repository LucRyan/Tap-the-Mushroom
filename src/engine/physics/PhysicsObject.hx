package engine.physics;
import engine.objects.SceneObject;
import box2D.collision.shapes.B2CircleShape;
import box2D.collision.shapes.B2PolygonShape;
import box2D.common.math.B2Vec2;
import box2D.dynamics.B2Body;
import box2D.dynamics.B2BodyDef;
import box2D.dynamics.B2DebugDraw;
import box2D.dynamics.B2FixtureDef;
import box2D.dynamics.B2World;
import engine.utils.ITickable;
import nme.events.Event;
import nme.Lib;

/**
 * ...
 * @author Yang Wang
 */
class PhysicsObject extends SceneObject, implements ITickable
{

	var body : B2Body;
	var fixtureDefinition : B2FixtureDef;
	var bodyDefinition : B2BodyDef;
	
	public function new() 
	{
		super();
	}
	
	public function tick() {
		updateBody();
	}
	
	/**
	 * Create the physics body with drawable.
	 * 
	 * @param   world
	 * @param	originWidth
	 * @param	originHeight
	 * @param	sizeLvl between 1 and 30;
	 * @param	positionX the exact X position 
	 * @param	positionY the exact Y position 
	 * @param	dynamicBody set true if you want it is dynamic
	 * @param	?movieClipPath 
	 */
	public function createBody (world : B2World, originWidth : Int, originHeight : Int, sizeLvl : Int, positionX : Float, positionY : Float, dynamicBody:Bool, ?movieClipPath : String):Void {
		
		var scaleWidth = Lib.current.stage.stageWidth / 30 * sizeLvl; // margin is width/10, and the scale offset is width/40.
		var scaleHeight = scaleWidth / originWidth * originHeight; // Scale the height with Image ratio.
		var scalePosX = Std.int(Lib.current.stage.stageWidth / 800 * positionX);
		var scalePosY = Std.int(Lib.current.stage.stageHeight / 480 * positionY);
		
		//Create the bodyDef and other parameters
		bodyDefinition = new B2BodyDef ();
		bodyDefinition.position.set (scalePosX * PhysicsScene.PHYSICS_SCALE, scalePosY * PhysicsScene.PHYSICS_SCALE);
		setObjectClip(scalePosX * PhysicsScene.PHYSICS_SCALE,  scalePosY * PhysicsScene.PHYSICS_SCALE, scaleWidth, scaleHeight, movieClipPath);
		
		if (dynamicBody) {
			bodyDefinition.type = B2Body.b2_dynamicBody;
		}
		
		//Now set the shape is polygon.
		var polygon = new B2PolygonShape();
		polygon.setAsBox ((scaleWidth / 2) * PhysicsScene.PHYSICS_SCALE, (scaleHeight / 2) * PhysicsScene.PHYSICS_SCALE);
		fixtureDefinition = new B2FixtureDef ();
		fixtureDefinition.shape = polygon;
	
		bodyDefinition.userData = objectClip;
		body = world.createBody (bodyDefinition);
		body.createFixture(fixtureDefinition);
		Lib.current.addChild(body.getUserData());
	}
	
	public function setFixtureDef( density : Float = 1.0, friction : Float = 0.3) : Void {
		body.m_fixtureList.setDensity(density);
		body.m_fixtureList.setFriction(friction);
		body.resetMassData();
	}
	
	private function updateBody() {
		body.getUserData().x = body.getPosition().x / PhysicsScene.PHYSICS_SCALE;
		body.getUserData().y = body.getPosition().y / PhysicsScene.PHYSICS_SCALE;
		objectClip.rotation = body.getAngle() * (180 / Math.PI);
	}
		
	private function setObjectClip( x:Float, y:Float, width:Float, height:Float, ?path : String) : Void {
		loadMovieClip((path == null) ? "TaptheMushroom:tm.RedMushroomJump" : path);
		objectClip.x = x;
		objectClip.y = y;
		objectClip.width = width;
		objectClip.height = height;
	}
	
	
}