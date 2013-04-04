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
	var screenWidth : Int;

	public function new(mushroom : Mushroom) 
	{	
		actor = mushroom;
		initialAccelerometer();
	}
	
	public function tick(?deltaTime : Float) {
		actor.tick();
	}
	
	public function delete() {
		if(nme.sensors.Accelerometer.isSupported) {
			accl.removeEventListener(AccelerometerEvent.UPDATE, onAccUpdate);
		}
	}
	
	public function getAcceleration() : B2Vec2 {
		return acceleration;
	}
	private function onAccUpdate(event : AccelerometerEvent): Void {
		var scale : Float = screenWidth / 25;
		acceleration.set(event.accelerationY * scale, event.accelerationX * scale);
	}
	
	private function initialAccelerometer() : Void{
		if(nme.sensors.Accelerometer.isSupported) {
			accl = new Accelerometer();
			controller = new B2ConstantAccelController();
			acceleration = new B2Vec2();
			
			actor.getBody().setSleepingAllowed(false);
			accl.addEventListener(AccelerometerEvent.UPDATE, onAccUpdate);
			screenWidth = Lib.current.stage.stageWidth;
		}
	}
	
}