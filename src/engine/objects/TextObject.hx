package engine.objects;
import engine.objects.SceneObject;
import nme.display.Sprite;
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

//TODO: THIS CLASS NEED REFACTOR!!!
class TextObject extends SceneObject
{
	public var displayText : TextField; 
	var fontFmt : TextFormat; 
	var customFont : Font;
	
	public function new(?font : String, ?background : String) 
	{
		super();
		loadMovieClip((background == null)? "TaptheMushroom:tm.TransparentBg" : background);
		//loadMovieClip((background == null)? "TaptheMushroom:tm.CountDownTimer" : background);
		initialize(font);
	}
	
	private function initialize(?font : String) {
		 displayText = new TextField();
		 customFont = Assets.getFont( (font == null) ? "fonts/SceneFonts.ttf" : font);
		 fontFmt = new TextFormat(customFont.fontName);
	 }
	 

	
	 /**
	  * TODO: This function should refactor.
	  * 
	  * @param	text
	  */
	public function resizeText(?text : String, ?color : Int) {
		 #if flash
			 displayText.x = objectClip.x - objectClip.width / 2 ;
			 displayText.y = objectClip.y - objectClip.height / 3 ;
			 displayText.width = objectClip.width;
			 displayText.height = objectClip.height;
		 #elseif android
			displayText.x = objectClip.x - objectClip.width  / 2.5;
			displayText.y = objectClip.y - objectClip.height / 3 ;
			displayText.width = objectClip.width;
			displayText.height = objectClip.height;
		 #end
		 
		 fontFmt.size = cast (Math.floor(objectClip.height * 7 / 10), Int);
		 fontFmt.color = (color == null) ? 0x000000 : color; 
		 displayText.embedFonts = true;
		 displayText.defaultTextFormat = fontFmt;
		 displayText.text = (text == null) ? "Default" : text;
		 displayText.selectable = false;
		 displayText.autoSize = TextFieldAutoSize.CENTER;
	 }
	 
	 public function addObjectToStage(stage : Sprite) {
		 stage.addChild(objectClip);
		 stage.addChild(displayText);
	 }
}