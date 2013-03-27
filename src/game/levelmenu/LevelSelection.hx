package game.levelmenu;
import engine.scene.BaseScene;
import game.common.utils.ButtonAdder;
import game.levelmenu.levels.LvlComing;
import game.levelmenu.levels.LvlTapemIcon;
import nme.events.Event;
import engine.objects.Button;
import engine.objects.SceneObject;

/**
 * ...
 * @author Yang Wang
 */
class LevelSelection extends BaseScene
{

	var buttonAdder : ButtonAdder;
	var levelsTable : Hash<Button>;
	var pageIcons : Hash<SceneObject>;
	
	public function new() 
	{
		super();	
		addEventListener (Event.ENTER_FRAME, this_onEnterFrame);
	}
	
	/**
	 * Override the construct which will load the stage when the level start.
	 */
	override private function construct () {
		buttonAdder = new ButtonAdder();
		initialLevelsTable();
		loadBackground("img/background.jpg");
		resize ();
		addObjects();

		//Handle resize
		stage.addEventListener(Event.RESIZE, stage_onResize);
	}
	
	// TODO: THIS FUNCTION NEED REFACTOR!!!!
	function addObjects() : Void {
		addChild(background);
		var count : Int = 0;
		for (i in levelsTable) {
			addChild(i.objectClip);
			if (count % 6 == 0 || count % 6 == 1 || count % 6 == 2) {
				i.resizeMovieClip(i.objectClip, 375, 230, 4, ((count % 3) * 5.5 + 3.5) / 18.0, (6.0) / 18.0);
			}else {
				i.resizeMovieClip(i.objectClip, 375, 230, 4, ((count % 3) * 5.5 + 3.5) / 18.0, (13.0) / 18.0);
			}
			count++;
		}
		
	}
	
	override private function resize () {
		resizeBackground();
		var count : Int = 0;
		for (i in levelsTable) {
			switch (count % 6) {
				case 0: case 1: case 2:
					i.resizeMovieClip(i.objectClip, 375, 230, 4, (count % 3 * 5 + 3.0) / 18.0, (6.0) / 18.0);
				case 3: case 4: case 5:
					i.resizeMovieClip(i.objectClip, 375, 230, 4, (count % 3 * 5 + 3.0) / 18.0, (13.0) / 18.0);
			}
			count++;
		}
	}
	
	private function initialLevelsTable() {
		levelsTable = new Hash<Button>();
		pageIcons = new Hash<SceneObject>();
		pageIcons.
		levelsTable.set("Level1", new LvlTapemIcon());
		levelsTable.set("Level2", new LvlComing());
		levelsTable.set("Level3", new LvlComing());
		levelsTable.set("Level4", new LvlComing());
		levelsTable.set("Level5", new LvlComing());
		levelsTable.set("Level6", new LvlComing());
	}
	
}