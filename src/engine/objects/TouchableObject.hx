package engine.objects;

import nme.events.MouseEvent;

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
		#else if android
		//TODO: ADD ANDROID TOUCH FUNCTION!!!
		#end 	
	}
	
	// Mouse functions for Touchable Object.
	public function mouseClick(mouseEvent : MouseEvent) {}
	
	private function mouseDoubleClick(mouseEvent : MouseEvent) {}
	
	private function mouseDown(mouseEvent : MouseEvent) {}
	
	private function mouseUp(mouseEvent : MouseEvent) {}
	
	private function mouseOver(mouseEvent : MouseEvent) { }
	
	private function mouseOut(mouseEvent : MouseEvent) {}
	
}