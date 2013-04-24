package game.levels.shake;
import engine.objects.SceneObject;
import engine.physics.PhysicsObject;
import engine.physics.PhysicsScene;
import engine.projectile.ProjectileEmitter;
import format.display.MovieClip;
import game.common.button.MenuButton;
import game.common.utils.TimerHelper;
import game.levels.shake.mushroom.Mushroom;
import game.levels.shake.utils.ShakeITContactListener;
import game.levels.shake.utils.WallStateGenerator;
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
import game.common.utils.ButtonHelper;
import engine.utils.SafeRemover;
import game.levels.shake.mushroom.MushController;
import game.levels.shake.utils.BodyType;
import engine.sound.SoundSystem;
import engine.utils.MTimer;
import engine.utils.ScreenShaker;
import game.common.utils.ScoreSystem;
import nme.events.TimerEvent;
import game.common.scene.LevelManager;

/**
 * ...
 * @author Yang Wang
 */
class ShakeItDnLvl extends PhysicsScene
{
	
	var buttonHelper : ButtonHelper;
	var timerHelper : TimerHelper;
	var mushroom : Mushroom;
	var wall : Hash<PhysicsObject>;
	var controller : MushController;
	var wlStateGen : WallStateGenerator;
	var projectileEmt : ProjectileEmitter;
	
	public function new() 
	{
		super();
		initialWorld(new B2Vec2(0, 0.0));
	}
	
	override function delete() {
		super.delete();
		buttonHelper.delete();
		controller.delete();
		projectileEmt.delete();
		this.removeEventListener(Event.ENTER_FRAME, this_onEnterFrame, true);
		this.removeEventListener(Event.RESIZE, stage_onResize, true);
	}
	
	/**
	 * Call this function when go into stage
	 */
	override private function construct ():Void {
		initialObjects();
		addObjects();
		setPhysicsData();
		
		//Add Listeners
		setContactListener();
		addEventListener (Event.ENTER_FRAME, this_onEnterFrame);
		stage.addEventListener(Event.RESIZE, stage_onResize);
	}

	//--------------------------------------- Gameplay Functions --------------------------------------------//
	/**
	 * When hit wall the State will change.
	 * 
	 * @param	wallName "Bottom", "Upper", "Left", "Right"
	 */
	var hitScore : Int = 0;
	private function hitWall(wallName : String) {
		if (wlStateGen.isActive(wallName)) {
			hitScore++;
			timerHelper.getCountTimer().startCount();
			SoundSystem.getInstance().playSoundFx("PokeMushroom", 1);
			wall.get(wallName).objectClip.visible = false;
			wlStateGen.afterHit(wallName);
			wlStateGen.genWallState();
		}
	}
	/**
	 * Generate the powerups
	 */
	private function genPowerUps() : Void {
		var emitPositionX : Float = (Math.random() * 18 / 20 * Lib.current.stage.stageWidth + 1 / 20 * Lib.current.stage.stageWidth);
		var choice : Int = Std.int(Math.random() * 3);
		var bodyType : String = new String("NULL");
		var texturePath : String = new String("NULL");
		switch(choice) {
			case 0 :
				bodyType = new String(BodyType.TIME_ADD);
				texturePath = "TaptheMushroom:tm.TimeAdd";
			case 1 :
				bodyType = new String(BodyType.SPEED_DOWN);
				texturePath = "TaptheMushroom:tm.SpeedDown";
			case 2 :
				bodyType = new String(BodyType.SPEED_UP);
				texturePath = "TaptheMushroom:tm.SpeedUp";
		}
		projectileEmt.setParameters(5 * 1000, 5 * 1000, 
									new B2Vec2(0, Lib.current.stage.stageHeight / 300 * 5), 
									new B2Vec2( emitPositionX * PhysicsScene.PHYSICS_SCALE, 
									0 * PhysicsScene.PHYSICS_SCALE), 0, 
									bodyType, texturePath);
		projectileEmt.tick();				
	}
	
	/**
	 * Handle eat timeAdd PowerUps
	 */
	private function timeAdd() : Void {
		projectileEmt.destoryAll();
		SoundSystem.getInstance().playSoundFx("Stars", 1);
		timerHelper.getCountTimer().addTime(5000);
	}
	
	private function speedUp() : Void {
		projectileEmt.destoryAll();
		SoundSystem.getInstance().playSoundFx("Stars", 1);
		controller.changeAccl(18);
	}
	
	private function speedDn() : Void {
		projectileEmt.destoryAll();
		SoundSystem.getInstance().playSoundFx("SpeedDown", 1);
		controller.changeAccl(35);
	}
	
	private function finished() : Void  {
		ScoreSystem.getInstance().checkScoreSKT(hitScore);
		var shaker : ScreenShaker = new ScreenShaker();
		shaker.startAnimation(this);
		MTimer.TIMER.getInstance().wait(1000, goToScoreBoard);
	}
	
	/**
	 * Page transfer
	 * @param	event
	 */
	private function goToScoreBoard(event: TimerEvent) {
		LevelManager.getInstance().changePages(ScoreBoards);
	}
		
	//------------------------------------------- Basic Functions ----------------------------------------//
	//
	private function initialObjects() {
		buttonHelper = new ButtonHelper();
		timerHelper = new TimerHelper(20000);
		wlStateGen = new WallStateGenerator();
		projectileEmt = new ProjectileEmitter(this, world);
		loadBackground("img/background.jpg");
		mushroom = new Mushroom(); 
		wall = new Hash<PhysicsObject>();
		wall.set("Bottom", new PhysicsObject());
		wall.set("Upper", new PhysicsObject());
		wall.set("Left", new PhysicsObject());
		wall.set("Right", new PhysicsObject());
	}
	//
	private function addObjects() : Void {
		resize();
		addChild(background);
		buttonHelper.addButtons(this);
		timerHelper.addTimerTo(this);
		
		//Add Actor
		addChild(mushroom.shadow);
		mushroom.createBody(this, world, 188, 155, 4, 400, 240, true, "TaptheMushroom:tm.ShakeMushroom");
		mushroom.objectClip.play();
		//Add controller to mushroom
		controller = new MushController(mushroom);
		
		//Add Visible Wall
		var stageWidth =  Lib.current.stage.stageWidth;
		var stageHeight = Lib.current.stage.stageHeight;
		wall.get("Bottom").createBody(this, world, stageWidth, 30, 30, 400, 480, false,"TaptheMushroom:tm.Blink");
		wall.get("Upper").createBody(this, world, stageWidth, 30, 30, 400, 0, false, "TaptheMushroom:tm.Blink");
		wall.get("Left").createBody(this, world, 30, stageHeight, 1, 0, 240, false, "TaptheMushroom:tm.Blink");
		wall.get("Right").createBody(this, world, 30, stageHeight, 1 , 800, 240, false, "TaptheMushroom:tm.Blink");
		//Set Visible to false.
		wall.get("Bottom").objectClip.visible = false;
		wall.get("Left").objectClip.visible = false;
		wall.get("Right").objectClip.visible = false;
	}
	//
	private function setPhysicsData() : Void {
		//Set physics data
		mushroom.setFixtureDef(1.0, 0.1, 0.1);
		wall.get("Bottom").setFixtureDef(1.0, 0.5, 0.1);
		wall.get("Upper").setFixtureDef(1.0, 0.5, 0.1);
		wall.get("Left").setFixtureDef(1.0, 0.5, 0.1);
		wall.get("Right").setFixtureDef(1.0, 0.5, 0.1);
		mushroom.setUserData(BodyType.MUSHROOM);
		wall.get("Bottom").setUserData(BodyType.GROUND_BOTTOM);
		wall.get("Upper").setUserData(BodyType.GROUND_UPPER);
		wall.get("Left").setUserData(BodyType.GROUND_LEFT);
		wall.get("Right").setUserData(BodyType.GROUND_RIGHT);
	}
	//
	private function setContactListener() {
		var contactListener = new ShakeITContactListener();
		contactListener.eventDispatcher.addEventListener(ShakeITContactListener.BOTTOM_START_CONTACT, onBottomStartContact);
		contactListener.eventDispatcher.addEventListener(ShakeITContactListener.UPPER_START_CONTACT, onUpperStartContact);
		contactListener.eventDispatcher.addEventListener(ShakeITContactListener.LEFT_START_CONTACT, onLeftStartContact);
		contactListener.eventDispatcher.addEventListener(ShakeITContactListener.RIGHT_START_CONTACT, onRightStartContact);
		contactListener.eventDispatcher.addEventListener(ShakeITContactListener.TIME_START_CONTACT, onTimeStartContact);
		contactListener.eventDispatcher.addEventListener(ShakeITContactListener.SPEEDDN_START_CONTACT, onSpeedDnStartContact);
		contactListener.eventDispatcher.addEventListener(ShakeITContactListener.SPEEDUP_START_CONTACT, onSpeedUpStartContact);
		world.setContactListener(contactListener);
	}
	
	//------------------------------------------------ Update Function ----------------------------------------------------//
	override private function update (?deltaTime : Float) : Void {
		//----------World Update--------------------------
		world.step (1 / 30, 10, 10);
		#if android
			world.setGravity(controller.getAcceleration());
		#end
		world.clearForces ();
		//world.drawDebugData ();
		
		controller.tick(); // Update gravity.
		for (i in wall) {
			i.tick(); // keep awake.
		};
		
		//---------------Gameplay Update------------------
		for (name in wall.keys()) {
			if (wlStateGen.isActive(name)) {
				wall.get(name).objectClip.visible = true;
			}
		}
		timerHelper.getCountTimer().tick();
		if (timerHelper.getCountTimer().isComplete()) {
			finished();
			timerHelper.getCountTimer().resetComplete();
		}
		//Projectiles -- Powerups
		genPowerUps();
	}
	
	//------------------------------------------------ Event Handlers ----------------------------------------------------//
	override private function resize () {
		super.resize();
		buttonHelper.resizeButtons();
		timerHelper.resizeTimer();
	}
	//-----------------------Walls------------------------------------------------
	//
	private function onBottomStartContact( event : Event) : Void { hitWall("Bottom");}
	//
	private function onUpperStartContact( event : Event) : Void { hitWall("Upper");}
	//
	private function onLeftStartContact( event : Event) : Void { hitWall("Left"); }
	//
	private function onRightStartContact( event : Event) : Void { hitWall("Right"); }
	
	//-----------------------PowerUps------------------------------------------------
	//
	private function onTimeStartContact( event : Event) : Void { timeAdd(); }
	//
	private function onSpeedUpStartContact( event : Event) : Void { speedUp(); }
	//
	private function onSpeedDnStartContact( event : Event) : Void { speedDn(); }

	
	
}