package engine.projectile;
import box2D.common.math.B2Vec2;
import game.shake.utils.BodyType;

/**
 * ...
 * @author Yang Wang
 */
class ProjectileData
{
	
	// Projectile
	public var pjName : String;
	public var projectile : Projectile; // the object we project
	public var plifeTime : Int = 0; // projectiles age
	public var pVelocity : B2Vec2; // projectiles speed
	public var pBodyType : String; // B2 World type
	public var texturePath : String; // for texture.

	public function new( name: String, lifeTime : Int, velocity : B2Vec2, bodyType : BodyType, texturePath: String ) 
	{
		this.pjName =  name;
		this.plifeTime = lifeTime; // projectiles age
		this.pVelocity = velocity; // projectiles speed
		this.pBodyType = bodyType; // B2 World type
		this.texturePath = texturePath; // for texture.
	}
	
	
}