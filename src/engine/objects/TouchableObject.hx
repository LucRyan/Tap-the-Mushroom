package engine.objects;

import nme.events.MouseEvent;
import nme.events.TouchEvent;

/**
 * Touchable Object
 * @author Yang Wang
 */

class TouchableObject extends SceneObject
{

	public function new() 
	{
		super();
	}

	/**
	 * Add all listener for Touchable Object.
	 * Designed for two platform.
	 */ 
	private function addListener() {
		objectClip.buttonMode = true;
		
		#if flash 
		objectClip.addEventListener(MouseEvent.CLICK, mouseClick, false, 0 , false);
		objectClip.addEventListener(MouseEvent.DOUBLE_CLICK, mouseDoubleClick, false, 0 , false);
		objectClip.addEventListener(MouseEvent.MOUSE_DOWN, mouseDown, false, 0 , false);
		objectClip.addEventListener(MouseEvent.MOUSE_UP, mouseUp, false, 0 , false);
		objectClip.addEventListener(MouseEvent.MOUSE_OVER, mouseOver, false, 0 , false);
		objectClip.addEventListener(MouseEvent.MOUSE_OUT, mouseOut, false, 0 , false);
		#elseif android
		//TODO: ADD ANDROID TOUCH FUNCTION!!!
		objectClip.addEventListener(TouchEvent.TOUCH_TAP, fingerTap, false, 0 , false);
		objectClip.addEventListener(TouchEvent.TOUCH_MOVE, fingerMove, false, 0 , false);
		objectClip.addEventListener(TouchEvent.TOUCH_OUT, fingerOut, false, 0 , false);
		objectClip.addEventListener(TouchEvent.TOUCH_OVER, fingerOver, false, 0 , false);
		objectClip.addEventListener(TouchEvent.TOUCH_BEGIN, fingerBegin, false, 0 , false);
		objectClip.addEventListener(TouchEvent.TOUCH_END, fingerEnd, false, 0 , false);
		#end 	
	}
	
	// Mouse functions for Touchable Object.
	public function mouseClick(mouseEvent : MouseEvent) {}
	
	private function mouseDoubleClick(mouseEvent : MouseEvent) {}
	
	private function mouseDown(mouseEvent : MouseEvent) {}
	
	private function mouseUp(mouseEvent : MouseEvent) {}
	
	private function mouseOver(mouseEvent : MouseEvent) { }
	
	private function mouseOut(mouseEvent : MouseEvent) { }
	
	// Mouse functions for Touchable Object.
	public function fingerTap(touchEvent : TouchEvent) {}
	
	private function fingerMove(touchEvent : TouchEvent) {}
	
	private function fingerOut(touchEvent : TouchEvent) {}
	
	private function fingerOver(touchEvent : TouchEvent) {}
	
	private function fingerBegin(touchEvent : TouchEvent) { }
	
	private function fingerEnd(touchEvent : TouchEvent) {}
	
}