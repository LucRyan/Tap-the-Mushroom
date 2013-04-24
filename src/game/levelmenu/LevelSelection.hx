package game.levelmenu;
import engine.scene.BaseScene;
import game.common.utils.ButtonHelper;
import game.levelmenu.levels.LvlComing;
import game.levelmenu.levels.LvlTapemIcon;
import game.levelmenu.levels.LvlShakeIt;
import game.levelmenu.utils.PageIcon;
import nme.events.Event;
import engine.objects.Button;
import engine.objects.SceneObject;
import game.levelmenu.levels.LvlBlowIt;
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
			resizeLevelTable(levelsTable.get("Level" + Std.string(count + 1)), count);
			count++;
		}
		count = 0;
		for (i in pageIcons) {
			addChild(i.objectClip);
			resizePageIcon(pageIcons.get("Page" + Std.string(count + 1)), count);
			count++;
		}
		
	}
	
	override private function resize () {
		resizeBackground();
		var count : Int = 0;
		for (i in levelsTable) {
			resizeLevelTable(levelsTable.get("Level" + Std.string(count + 1)), count);
			count++;
		}
		count = 0;
		for (i in pageIcons) {
			resizePageIcon(pageIcons.get("Page" + Std.string(count + 1)), count);
			count++;
		}
	}
	
	private function resizeLevelTable(levelIcon : Button, index : Int) {
		if (index % 4 == 0 || index % 4 == 1 ) {
			levelIcon.resizeMovieClip(levelIcon.objectClip, 375, 230, 3, ((index % 2) * 8.5 + 4.8) / 18.0, (5.0) / 18.0);
		}else {
			levelIcon.resizeMovieClip(levelIcon.objectClip, 375, 230, 3, ((index % 2) * 8.5 + 4.8) / 18.0, (12.5) / 18.0);
		}
	}
	private function resizePageIcon(page : SceneObject, index : Int) {
			page.resizeMovieClip(page.objectClip, 113, 113, 40, (index / 1.5 + 8.5) / 18.0, (17) / 18.0);
	}
	
	private function initialLevelsTable() {
		levelsTable = new Hash<Button>();
		pageIcons = new Hash<SceneObject>();
		pageIcons.set("Page1", new PageIcon(true));
		pageIcons.set("Page2", new PageIcon());
		pageIcons.set("Page3", new PageIcon());
		levelsTable.set("Level1", new LvlTapemIcon());
		levelsTable.set("Level2", new LvlShakeIt());
		levelsTable.set("Level3", new LvlBlowIt());
		levelsTable.set("Level4", new LvlComing());
	}
	
}