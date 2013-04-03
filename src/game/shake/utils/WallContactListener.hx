package game.shake.utils;

import box2D.collision.B2Manifold;
import box2D.dynamics.B2ContactImpulse;
import box2D.dynamics.B2ContactListener;
import box2D.dynamics.contacts.B2Contact;
import nme.events.Event;
import nme.events.EventDispatcher;

/**
 * ...
 * @author Yang Wang
 */
class WallContactListener extends B2ContactListener
{

	public static inline var BOTTOM_START_CONTACT : String = "bottomStartContact";
    public static inline var UPPER_START_CONTACT : String = "upperStartContact";
	public static inline var LEFT_START_CONTACT : String = "leftStartContact";
    public static inline var RIGHT_START_CONTACT : String = "rightStartContact";
	
    public var eventDispatcher:EventDispatcher;
		
		
	public function new() 
	{
		super();
		eventDispatcher = new EventDispatcher();
	}
	
	override public function beginContact(contact:B2Contact):Void 
	{
		super.beginContact(contact);
		//
		if (contact.getFixtureA().getBody().getUserData() == BodyType.GROUND_BOTTOM &&
			contact.getFixtureB().getBody().getUserData() == BodyType.MUSHROOM ||
			contact.getFixtureB().getBody().getUserData() == BodyType.GROUND_BOTTOM &&
			contact.getFixtureA().getBody().getUserData() == BodyType.MUSHROOM ) {
				eventDispatcher.dispatchEvent( new Event(BOTTOM_START_CONTACT));
			}
		if (contact.getFixtureA().getBody().getUserData() == BodyType.GROUND_UPPER &&
			contact.getFixtureB().getBody().getUserData() == BodyType.MUSHROOM ||
			contact.getFixtureB().getBody().getUserData() == BodyType.GROUND_UPPER &&
			contact.getFixtureA().getBody().getUserData() == BodyType.MUSHROOM ) {
				eventDispatcher.dispatchEvent( new Event(UPPER_START_CONTACT));
			}
		if (contact.getFixtureA().getBody().getUserData() == BodyType.GROUND_LEFT &&
			contact.getFixtureB().getBody().getUserData() == BodyType.MUSHROOM ||
			contact.getFixtureB().getBody().getUserData() == BodyType.GROUND_LEFT &&
			contact.getFixtureA().getBody().getUserData() == BodyType.MUSHROOM ) {
				eventDispatcher.dispatchEvent( new Event(LEFT_START_CONTACT));
			}
		if (contact.getFixtureA().getBody().getUserData() == BodyType.GROUND_RIGHT &&
			contact.getFixtureB().getBody().getUserData() == BodyType.MUSHROOM ||
			contact.getFixtureB().getBody().getUserData() == BodyType.GROUND_RIGHT &&
			contact.getFixtureA().getBody().getUserData() == BodyType.MUSHROOM ) {
				eventDispatcher.dispatchEvent( new Event(RIGHT_START_CONTACT));
			}
	}
	
	override public function endContact(contact:B2Contact):Void 
	{
		super.endContact(contact);
	}
	
	override public function preSolve(contact:B2Contact, oldManifold:B2Manifold):Void 
	{
		super.preSolve(contact, oldManifold);
	}
	
	override public function postSolve(contact:B2Contact, impulse:B2ContactImpulse):Void 
	{
		super.postSolve(contact, impulse);
	}
	

	
}