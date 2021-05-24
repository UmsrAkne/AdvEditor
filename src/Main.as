package {
    import flash.display.Sprite;
    import classes.gameScenes.ScenarioScene;
    import flash.display.StageScaleMode;
    import flash.display.StageAlign;

    /**
     * ...
     * @author
     */
    public class Main extends Sprite {

        public function Main() {
            stage.align = StageAlign.TOP_LEFT;
            stage.scaleMode = StageScaleMode.NO_SCALE;
            addChild(new ScenarioScene);
        }

    }

}
