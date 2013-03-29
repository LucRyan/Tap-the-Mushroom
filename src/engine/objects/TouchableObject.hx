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

	public function delete() {
		objectClip.buttonMode = false;
		
		objectClip.removeEventListener(MouseEvent.CLICK, mouseClick, false);
		objectClip.removeEventListener(MouseEvent.DOUBLE_CLICK, mouseDoubleClick, false);
		objectClip.removeEventListener(MouseEvent.MOUSE_DOWN, mouseDown, false);
		objectClip.removeEventListener(MouseEvent.MOUSE_UP, mouseUp, false);
		objectClip.removeEventListener(MouseEvent.MOUSE_OVER, mouseOver, false);
		objectClip.removeEventListener(MouseEvent.MOUSE_OUT, mouseOut, false);
	}
	/**
	 * Add all listener for Touchable Object.
	 * Designed for two platform.
	 */ 
	private function addListener() {
		objectClip.buttonMode = true;
		
		objectClip.addEventListener(MouseEvent.CLICK, mouseClick, false, 0 , false);
		objectClip.addEventListener(MouseEvent.DOUBLE_CLICK, mouseDoubleClick, false, 0 , false);
		objectClip.addEventListener(MouseEvent.MOUSE_DOWN, mouseDown, false, 0 , false);
		objectClip.addEventListener(MouseEvent.MOUSE_UP, mouseUp, false, 0 , false);
		objectClip.addEventListener(MouseEvent.MOUSE_OVER, mouseOver, false, 0 , false);
		objectClip.addEventListener(MouseEvent.MOUSE_OUT, mouseOut, false, 0 , false);

	}
	
	// Mouse functions for Touchable Object.
	public function mouseClick(mouseEvent : MouseEvent) {}
	
	private function mouseDoubleClick(mouseEvent : MouseEvent) {}
	
	private function mouseDown(mouseEvent : MouseEvent) {}
	
	private function mouseUp(mouseEvent : MouseEvent) {}
	
	private function mouseOver(mouseEvent : MouseEvent) { }
	
	private function mouseOut(mouseEvent : MouseEvent) { }
	
}