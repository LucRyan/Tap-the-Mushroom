package game.common.displayItem;
import engine.objects.TextObject;
import nme.events.TimerEvent;
import nme.text.Font;
import nme.text.TextField;
import nme.text.TextFormat;
import nme.text.TextFieldAutoSize;
import engine.sound.SoundSystem;

/**
 * ...
 * @author Yang Wang
 */

class Stars extends TextObject
{

	public function new(?font : String) 
	{
		super();
		initialize(font);
		loadMovieClip("TaptheMushroom:tm.StarsNoMask");
		objectClip.gotoAndStop(2);
	}
	
	 /**
	  * TODO: This function should refactor.
	  * 
	  * @param	text
	  */
	override public function resizeText(?text : String, ?color : Int) {
		 displayText.x = objectClip.x - objectClip.width / 2 ;
		 displayText.y = objectClip.y + objectClip.height / 1.5 ;
		 displayText.width = objectClip.width;
		 displayText.height = objectClip.height;
		 
		 fontFmt.size = cast (Math.floor(objectClip.height * 3 / 10), Int);
		 fontFmt.color = (color == null) ? 0x000000 : color; 
		 displayText.embedFonts = true;
		 displayText.defaultTextFormat = fontFmt;
		 displayText.text = (text == null) ? "Default" : text;
		 displayText.selectable = false;
		 displayText.autoSize = TextFieldAutoSize.CENTER;
	 }
	 
	 public function playAnimation(?event : TimerEvent) {
		 objectClip.play();
		 SoundSystem.SOUND_SYSTEM.getInstance().playSoundFx("MenuButton");
	 }
	 
	 public function stopAnimation(?event : TimerEvent) {
		 objectClip.gotoAndStop(15);
	 }
	
	
}