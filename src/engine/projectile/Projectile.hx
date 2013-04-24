package engine.projectile;
import box2D.common.math.B2Vec2;
import engine.physics.PhysicsObject;
import box2D.common.math.B2Vec2;
import box2D.collision.shapes.B2PolygonShape;
import box2D.dynamics.B2Body;
import box2D.dynamics.B2BodyDef;
import box2D.dynamics.B2DebugDraw;
import box2D.dynamics.B2FixtureDef;
import box2D.dynamics.B2World;
import engine.utils.ITickable;
import nme.events.Event;
import nme.Lib;
import engine.physics.PhysicsScene;

/**
 * ...
 * @author Yang Wang
 */
class Projectile extends PhysicsObject
{	
	var birthTime : Int;
	var lifeTime : Int;
	
	public function new() 
	{
		super();
	}
	
	/**
	 * Create the physics body with drawable.
	 * 
	 * @param	originWidth
	 * @param	originHeight
	 * @param	sizeLvl between 1 and 30;
	 * @param	dynamicBody set true if you want it is dynamic
	 * @param	?movieClipPath 
	 */
    public function setParameters (originWidth : Int, originHeight : Int, sizeLvl : Float, ?movieClipPath : String):Void {
		
		var scaleWidth = Lib.current.stage.stageWidth / 30 * sizeLvl; // margin is width/10, and the scale offset is width/40.
		var scaleHeight = scaleWidth / originWidth * originHeight; // Scale the height with Image ratio.
		
		//Create the bodyDef and other parameters
		bodyDefinition = new B2BodyDef ();
		bodyDefinition.type = B2Body.b2_kinematicBody;
		
		var polygon = new B2PolygonShape();
		polygon.setAsBox ((scaleWidth / 2) * PhysicsScene.PHYSICS_SCALE, (scaleHeight / 2) * PhysicsScene.PHYSICS_SCALE);
		setTexture(scaleWidth, scaleHeight, movieClipPath);
		fixtureDefinition = new B2FixtureDef ();
		fixtureDefinition.shape = polygon;
	}
	
	private function setTexture( width:Float, height:Float, ?path : String) : Void {
		loadMovieClip((path == null) ? "TaptheMushroom:tm.RedMushroomJump" : path);
		objectClip.width = width;
		objectClip.height = height;
	}
	
	public function getBodyDef() :B2BodyDef {
		return bodyDefinition;
	}
	
	public function getFixDef() : B2FixtureDef{
		return fixtureDefinition;
	}
	
	public function setLifeTime( lifeTime : Int) : Void {
		this.lifeTime = lifeTime;
	}
	
	public function getLifeTime() : Int {
		return lifeTime;
	}
	
	public function setBirthTime( birthTime : Int) : Void {
		this.birthTime = birthTime;
	}
	
	public function getBirthTime() : Int {
		return birthTime;
	}
	
}