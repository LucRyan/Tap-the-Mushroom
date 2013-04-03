package game.shake;
import engine.objects.SceneObject;
import engine.physics.PhysicsObject;
import engine.physics.PhysicsScene;
import format.display.MovieClip;
import game.common.button.MenuButton;
import game.shake.mushroom.Mushroom;
import game.shake.utils.WallContactListener;
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
import game.shake.utils.BodyType;

/**
 * ...
 * @author Yang Wang
 */
class ShakeItDnLvl extends PhysicsScene
{
	
	var buttonAdder : ButtonAdder;
	var mushroom : Mushroom;
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
	
	/**
	 * Call this function when go into stage
	 */
	override private function construct ():Void {
		initialObjects();
		addObjects();
		setPhysicsData();
		setContactListener();
		
		addEventListener (Event.ENTER_FRAME, this_onEnterFrame);
	}
	
	//------------------------------------------- Basic Methods ----------------------------------------//
	//
	private function initialObjects() {
		buttonAdder = new ButtonAdder();
		loadBackground("img/background.jpg");
		mushroom = new Mushroom(); 
		
		wall = new Hash<PhysicsObject>();
		wall.set("bottom", new PhysicsObject());
		wall.set("upper", new PhysicsObject());
		wall.set("left", new PhysicsObject());
		wall.set("right", new PhysicsObject());
	}
	//
	private function addObjects() : Void {
		addChild(background);
		buttonAdder.addButtons(this);
		//Add Actor
		mushroom.createBody(this, world, 188, 155, 4, 350, 50, true);
		controller = new MushController(mushroom);
		//Add Visible Wall
		var stageWidth =  Lib.current.stage.stageWidth;
		var stageHeight = Lib.current.stage.stageHeight;
		wall.get("bottom").createBody(this, world, stageWidth, 1, 60, 0, 480, false);
		wall.get("upper").createBody(this, world, stageWidth, 1, 60, 10, 0, false);
		wall.get("left").createBody(this, world, 1, stageHeight, 1/10, 0, 0, false);
		wall.get("right").createBody(this, world, 1, stageHeight, 1/10, 800, 0, false);
	}
	//
	private function setPhysicsData() : Void {
		//Set physics data
		mushroom.setFixtureDef(1.0, 0.1, 0.1);
		wall.get("bottom").setFixtureDef(1.0, 0.5, 0.1);
		wall.get("upper").setFixtureDef(1.0, 0.5, 0.1);
		wall.get("left").setFixtureDef(1.0, 0.5, 0.1);
		wall.get("right").setFixtureDef(1.0, 0.5, 0.1);
		mushroom.setUserData(BodyType.MUSHROOM);
		wall.get("bottom").setUserData(BodyType.GROUND_BOTTOM);
		wall.get("upper").setUserData(BodyType.GROUND_UPPER);
		wall.get("left").setUserData(BodyType.GROUND_LEFT);
		wall.get("right").setUserData(BodyType.GROUND_RIGHT);
	}
	//
	private function setContactListener() {
		var contactListener = new WallContactListener();
		contactListener.eventDispatcher.addEventListener(WallContactListener.BOTTOM_START_CONTACT, onBottomStartContact);
		contactListener.eventDispatcher.addEventListener(WallContactListener.UPPER_START_CONTACT, onUpperStartContact);
		contactListener.eventDispatcher.addEventListener(WallContactListener.LEFT_START_CONTACT, onLeftStartContact);
		contactListener.eventDispatcher.addEventListener(WallContactListener.RIGHT_START_CONTACT, onRightStartContact);
		world.setContactListener(contactListener);
	}
	
	//--------------------------------------- Gameplay Methods --------------------------------------------//
	//
	private function hitWall() {
		
	}
	
	
	//------------------------------------------------ Event Handlers ----------------------------------------------------//
	override private function update (?deltaTime : Float) : Void {
		world.step (1 / 30, 10, 10);
		#if android
			world.setGravity(controller.getAcceleration());
		#end
		world.clearForces ();
		world.drawDebugData ();
		
		controller.tick();
		for (i in wall) {
			i.tick();
		};
	}
	
	private function onBottomStartContact( event : Event) : Void {
		
	}
	private function onUpperStartContact( event : Event) : Void {
		
	}
	private function onLeftStartContact( event : Event) : Void {
		
	}
	private function onRightStartContact( event : Event) : Void {
		
	}
	
	
	
	
}