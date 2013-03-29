package game.shake;
import engine.objects.SceneObject;
import engine.physics.PhysicsObject;
import engine.physics.PhysicsScene;
import format.display.MovieClip;
import game.shake.mushroom.Mushroom;
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
import game.shake.mushroom.MushController;

/**
 * ...
 * @author Yang Wang
 */
class ShakeItDnLvl extends PhysicsScene
{
	
	var buttonAdder : ButtonAdder;
	var mushroom : Mushroom;
	var block : PhysicsObject;
	var wall : Hash<PhysicsObject>;
	var controller : MushController;
	
	public function new() 
	{
		super();
		initialWorld(new B2Vec2(0, 0.0));
		addEventListener (Event.ENTER_FRAME, this_onEnterFrame);
	}
	
	override function delete() {
		super.delete();
		buttonAdder.delete();
		controller.delete();
		removeEventListener(Event.ENTER_FRAME, this_onEnterFrame, true);
	}
	
	
	override private function construct ():Void {
		initialObjects();
		addObjects();
		
		mushroom = new Mushroom(); 
		mushroom.createBody(this, world, 188, 155, 4, 350, 50, true);
		mushroom.setFixtureDef(1.0, 0.1, 0.1);
		controller = new MushController(mushroom);
		
		wall = new Hash<PhysicsObject>();
		wall.set("bottom", new PhysicsObject());
		wall.set("upper", new PhysicsObject());
		wall.set("left", new PhysicsObject());
		wall.set("right", new PhysicsObject());
	
		wall.get("bottom").createBody(this, world, 1000, 1, 60, 0, 470, false);
		wall.get("upper").createBody(this, world, 1000, 1, 60, 10, 0, false);
		wall.get("left").createBody(this, world, 1, 10000, 0.1, 0, 0, false);
		wall.get("right").createBody(this, world, 1, 10000, 0.1, 800, 0, false);
		wall.get("bottom").setFixtureDef(1.0, 0.5, 0.1);
		wall.get("upper").setFixtureDef(1.0, 0.5, 0.1);
		wall.get("left").setFixtureDef(1.0, 0.5, 0.1);
		wall.get("right").setFixtureDef(1.0, 0.5, 0.1);
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
		#if android
			world.setGravity(controller.getAcceleration());
		#end
		world.clearForces ();
		world.drawDebugData ();
		
		//sizeLvl -= 0.1;
		//mushroom.resizeBody(188, 155, sizeLvl);
		controller.tick();
		for (i in wall) {
			i.tick();
		};
	}
	
	
	
	
}