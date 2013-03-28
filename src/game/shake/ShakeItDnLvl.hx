package game.shake;
import engine.objects.SceneObject;
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
	var clip : Bitmap;
	
	public function new() 
	{
		super();
		initialWorld(new B2Vec2(0, 10.0));
		addEventListener (Event.ENTER_FRAME, this_onEnterFrame);
	}
	
	override private function construct ():Void {
		createBox (400, 400, 800, 10, false);
		
		createBox (250, 100, 100, 100, true);
		
		
		addEventListener (Event.ENTER_FRAME, this_onEnterFrame);
	}
	
	var body : B2Body;
	private function createBox (x:Float, y:Float, width:Float, height:Float, dynamicBody:Bool):Void {
		
		var bodyDefinition = new B2BodyDef ();
		clip = new Bitmap(Assets.getBitmapData("img/TapThemAll/bMushroom.png"));
		bodyDefinition.position.set (x * PHYSICS_SCALE, y * PHYSICS_SCALE);

		if (dynamicBody) {
			bodyDefinition.type = B2Body.b2_dynamicBody;
		}
		
		var polygon = new B2PolygonShape ();
		polygon.setAsBox ((width / 2) * PHYSICS_SCALE, (height / 2) * PHYSICS_SCALE);
		
		var fixtureDefinition = new B2FixtureDef ();
		fixtureDefinition.shape = polygon;
		bodyDefinition.userData = clip;
		clip.x = x * PHYSICS_SCALE;
		clip.y = y * PHYSICS_SCALE;
		
		body = world.createBody (bodyDefinition);
		body.createFixture (fixtureDefinition);
		
		addChild(body.getUserData());
	}
	
	private function drawCLip() : Void{
		clip.x = body.getPosition().x / PHYSICS_SCALE;
		clip.y = body.getPosition().y / PHYSICS_SCALE;
	}
	
	
	// Event Handlers
	
	override private function update (?deltaTime : Float) : Void {
		drawCLip();
		world.step (1 / 30, 10, 10);
		world.clearForces ();
		world.drawDebugData ();
		
	}
	
	
	
	
}