package engine.projectile;
import box2D.common.math.B2Vec2;
import box2D.dynamics.B2World;
import engine.scene.BaseScene;
import engine.utils.ITickable;
import engine.utils.SafeRemover;
import game.shake.utils.BodyType;
import nme.Lib;

/**
 * ...
 * @author Yang Wang
 */
class ProjectileEmitter implements ITickable
{
	// Projectile
	var projectile : Projectile; // the object we project
	var plifeTime : Int = 0; // projectiles age
	var pVelocity : B2Vec2; // projectiles speed
	var pBodyType : String; // B2 World type
	var texturePath : String; // for texture.
	
	// Emitter
	var pjList : Array<Projectile>; // Contains all projectiles.
	var emitPosition : B2Vec2; // start position
	var emitDirection : Float; // start direction
	var gravity : Bool = false; // whether it affect by gravity
	var lastEmitTime : Int = 0; // for update
	var reloadTime : Int; // time between two emit
	var stage : BaseScene; // define which stage we use
	var world : B2World; // which box2d world we use.
	
	
	public function new(stage : BaseScene, world:B2World)
	{
		pjList = new Array<Projectile>();
		this.world = world;
		this.stage = stage;
	}
	
	public function delete() {
		SafeRemover.safeRemove(this);
	}
	
	public function tick(?deltaTime : Float) : Void {
		if (reloadTime <= Lib.getTimer() - lastEmitTime) {
			emitProjectile();
		}
		
		// Update function.
		for (p in pjList) {
			updateProjectile(p);
			if (p.getLifeTime() <= Lib.getTimer() - p.getBirthTime()) {
				destoryProjectile(p);
			}
		}
	}
	
	/**
	 * Call this function before emitting the Projectile.
	 * @param	lifeTime projectiles age
	 * @param	velocity projectiles speed
	 * @param	bodyType use for collision
	 * @param	reloadTime time between two emit
	 * @param	emitPosition start position
	 * @param	emitDirection start direction
	 */
	public function setParameters(lifeTime : Int = 10 * 1000, reloadTime : Int = 5 * 1000, 
								  velocity : B2Vec2, emitPosition : B2Vec2, emitDirection : Float = 0,
								  bodyType : String, texturePath : String) : Void 
	{
		this.plifeTime = lifeTime; // projectiles age
		this.pVelocity = velocity; // projectiles speed
		this.pBodyType = bodyType;
		this.reloadTime = reloadTime; // time between two emit
		this.emitPosition = emitPosition; // start position
		this.emitDirection = emitDirection; // start direction
		this.texturePath = texturePath; //
	}
	
	private function emitProjectile() : Void {
		// Create and set projectile
		projectile = new Projectile();
		projectile.setParameters(188, 155, 2, this.texturePath); // Set drawable and body width and height
		projectile.body = world.createBody(projectile.getBodyDef()); // create the body to world
		projectile.body.createFixture(projectile.getFixDef()); // create fixture
		projectile.body.setLinearVelocity(pVelocity); // set the start Velocity.
		projectile.body.setPositionAndAngle(emitPosition, emitDirection); // set the start position.
		projectile.body.setBullet(false); // Set bullet available
		projectile.setLifeTime(plifeTime); // set life time
		projectile.setBirthTime(Lib.getTimer()); // set birth time
		projectile.setUserData(pBodyType); // set user data.
	
		//Add to list and stage.
		lastEmitTime = Lib.getTimer();
		pjList.push(projectile);
		stage.addChildAt(projectile.objectClip, stage.numChildren);
	}
	
	private function updateProjectile(p : Projectile) : Void{
		p.tick(); // update the texture.
	}
	
	public function destoryProjectile(p : Projectile) {
		stage.removeChild(p.objectClip);
		world.destroyBody(p.body);
		pjList.remove(p);
	}
	

}