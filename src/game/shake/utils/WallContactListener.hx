package game.shake.utils;

import box2D.collision.B2Manifold;
import box2D.dynamics.B2ContactImpulse;
import box2D.dynamics.B2ContactListener;
import box2D.dynamics.contacts.B2Contact;
import nme.events.EventDispatcher;

/**
 * ...
 * @author Yang Wang
 */
class WallContactListener extends B2ContactListener
{

	public static const BLUE_BALL_START_CONTACT:String = "blueBallStartContact";
    public static const RED_BALL_START_CONTACT:String = "redBallStartContact";
    public var eventDispatcher:EventDispatcher;
		
		
	public function new() 
	{
		eventDispatcher = new EventDispatcher();
	}
	
	override public function beginContact(contact:B2Contact):Void 
	{
		super.beginContact(contact);
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