package engine.objects;
import engine.objects.SceneObject;
import nme.text.Font;
import nme.text.TextField;
import nme.text.TextFormat;
import nme.text.TextFieldAutoSize;
import nme.Assets;
import nme.utils.Timer;
import nme.events.TimerEvent;

/**
 * ...
 * @author Yang Wang
 */

class TextObject extends SceneObject
{
	public var displayText : TextField; 
	var fontFmt : TextFormat; 
	var customFont : Font;
	
	public function new() 
	{
		super();
	}
	
	private function initialize() {
		 displayText = new TextField();
		 customFont = Assets.getFont("fonts/SceneFonts.ttf");
		 fontFmt = new TextFormat(customFont.fontName);
	 }
	
	 /**
	  * TODO: This function should refactor.
	  * 
	  * @param	text
	  */
	public function resizeText(text : String) {
		 displayText.x = objectClip.x - objectClip.width / 2 ;
		 displayText.y = objectClip.y - objectClip.height / 3 ;
		 displayText.width = objectClip.width;
		 displayText.height = objectClip.height;
		 
		 fontFmt.size = cast (Math.floor(objectClip.height * 7 / 10), Int);
		 fontFmt.color = 0x000000; 
		 displayText.embedFonts = true;
		 displayText.defaultTextFormat = fontFmt;
		 displayText.text = text;
		 displayText.selectable = false;
		 displayText.autoSize = TextFieldAutoSize.CENTER;
	 }
}