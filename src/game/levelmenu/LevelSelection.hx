package game.levelmenu;
import engine.scene.BaseScene;
import game.common.utils.ButtonHelper;
import game.levelmenu.levels.LvlComing;
import game.levelmenu.levels.LvlTapemIcon;
import game.levelmenu.utils.PageIcon;
import nme.events.Event;
import engine.objects.Button;
import engine.objects.SceneObject;
import nme.Lib;

/**
 * ...
 * @author Yang Wang
 */
class LevelSelection extends BaseScene
{	
	var buttonHelper : ButtonHelper;
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
		buttonHelper = new ButtonHelper();
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
			resizeLevelTable(i, count);
			count++;
		}
		count = 0;
		for (i in pageIcons) {
			addChild(i.objectClip);
			resizePageIcon(i, count);
			count++;
		}
		
	}
	
	override private function resize () {
		resizeBackground();
		var count : Int = 0;
		for (i in levelsTable) {
			resizeLevelTable(i, count);
			count++;
		}
		for (i in pageIcons) {
			resizePageIcon(i, count);
			count++;
		}
	}
	
	private function resizeLevelTable(levelIcon : Button, index : Int) {
		if (index % 6 == 0 || index % 6 == 1 || index % 6 == 2) {
			levelIcon.resizeMovieClip(levelIcon.objectClip, 375, 230, 4, ((index % 3) * 5.5 + 3.5) / 18.0, (6.0) / 18.0);
		}else {
			levelIcon.resizeMovieClip(levelIcon.objectClip, 375, 230, 4, ((index % 3) * 5.5 + 3.5) / 18.0, (13.0) / 18.0);
		}
	}
	private function resizePageIcon(page : SceneObject, index : Int) {
			page.resizeMovieClip(page.objectClip, 113, 113, 40, (index / 1.5 + 8.5) / 18.0, (16.5) / 18.0);
	}
	
	private function initialLevelsTable() {
		levelsTable = new Hash<Button>();
		pageIcons = new Hash<SceneObject>();
		pageIcons.set("Page1", new PageIcon(true));
		pageIcons.set("Page2", new PageIcon());
		pageIcons.set("Page3", new PageIcon());
		levelsTable.set("Level1", new LvlTapemIcon());
		levelsTable.set("Level2", new LvlComing());
		levelsTable.set("Level3", new LvlComing());
		levelsTable.set("Level4", new LvlComing());
		levelsTable.set("Level5", new LvlComing());
		levelsTable.set("Level6", new LvlComing());
	}
	
}