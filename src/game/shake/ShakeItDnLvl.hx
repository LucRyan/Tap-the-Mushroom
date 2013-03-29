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
import game.common.utils.ButtonAdder;
import engine.utils.SafeRemover;

/**
 * ...
 * @author Yang Wang
 */
class ShakeItDnLvl extends PhysicsScene
{
	
	var buttonAdder : ButtonAdder;
	var mushroom : PhysicsObject;
	var wall : PhysicsObject;
	
	public function new() 
	{
		super();
		initialWorld(new B2Vec2(0, 10.0));
		addEventListener (Event.ENTER_FRAME, this_onEnterFrame);
	}
	
	override function delete() {
		super.delete();
		buttonAdder.delete();
		removeEventListener(Event.ENTER_FRAME, this_onEnterFrame, true);
		//world.getBodyList(
	}
	
	
	override private function construct ():Void {
		initialObjects();
		addObjects();
		
		mushroom = new PhysicsObject(); 
		
		mushroom.createBody(this, world, 188, 155, 4, 350, 50, true);


		mushroom.setFixtureDef(1.0, 0.3);
		wall = new PhysicsObject();
	
		wall.createBody(this, world, 188, 155, 2, 400, 400, false);


		
		addEventListener (Event.ENTER_FRAME, this_onEnterFrame);
	}
	
	private function initialObjects() {
		buttonAdder = new ButtonAdder();
		loadBackground("img/background.jpg");
	}
	private function addObjects() : Void {
		//addChild(background);
		buttonAdder.addButtons(this);
	}
	
	// Event Handlers
		var sizeLvl : Float = 4;
	override private function update (?deltaTime : Float) : Void {
		world.step (1 / 30, 10, 10);
		world.clearForces ();
		world.drawDebugData ();
		//sizeLvl -= 0.1;
		//mushroom.resizeBody(188, 155, sizeLvl);
		mushroom.tick(0.5);
		wall.tick();
	}
	
	
	
	
}