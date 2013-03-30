package game.shake.mushroom;
import box2D.common.math.B2Vec2;
import box2D.dynamics.B2TimeStep;
import engine.objects.SceneObject;
import engine.scene.BaseScene;
import game.common.button.MenuButton;
import nme.sensors.Accelerometer;
import nme.events.AccelerometerEvent;
import box2D.dynamics.controllers.B2ConstantAccelController;
import engine.utils.ITickable;
import nme.Lib;



/**
 * ...
 * @author Yang Wang
 */
class MushController implements ITickable
{
	
	var actor : Mushroom;
	var accl : Accelerometer;
	var controller : B2ConstantAccelController;
	var acceleration : B2Vec2;

	public function new(mushroom : Mushroom) 
	{	
		actor = mushroom;
		initialAccelerometer();
	}
	
	public function tick(?deltaTime : Float) {
		actor.tick(0.5);
	}
	
	public function delete() {
		accl.removeEventListener(AccelerometerEvent.UPDATE, onAccUpdate);
	}
	
	public function getAcceleration() : B2Vec2 {
		return acceleration;
	}
	private function onAccUpdate(event : AccelerometerEvent): Void {
	
		acceleration.set(event.accelerationY * 10, 0);
	}
	
	private function initialAccelerometer() : Void{
		if(nme.sensors.Accelerometer.isSupported) {
			accl = new Accelerometer();
			controller = new B2ConstantAccelController();
			actor.getBody().setSleepingAllowed(false);
			acceleration = new B2Vec2();
			accl.setRequestedUpdateInterval(0);
			accl.addEventListener(AccelerometerEvent.UPDATE, onAccUpdate);
		}
	}
	
}