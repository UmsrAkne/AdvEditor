package {
    import flash.display.Sprite;
    import classes.gameScenes.ScenarioScene;
    import flash.display.StageScaleMode;
    import flash.display.StageAlign;
    import classes.gameScenes.LoadingScene;
    import flash.events.Event;
    import flash.filesystem.File;

    /**
     * ...
     * @author
     */
    public class Main extends Sprite {

        private var loadingScene:LoadingScene;
        private var scenarioScene:ScenarioScene;

        public function Main() {
            stage.align = StageAlign.TOP_LEFT;
            stage.scaleMode = StageScaleMode.NO_SCALE;

            loadingScene = new LoadingScene(new File(File.applicationDirectory.nativePath).resolvePath("../scenarios/sampleScenario"));
            loadingScene.load();
            loadingScene.addEventListener(Event.COMPLETE, loadCompleteEventHandler);
        }

        private function loadCompleteEventHandler(event:Event):void {
            scenarioScene = new ScenarioScene();
            scenarioScene.setResource(LoadingScene(event.target).getResouce());
            addChild(scenarioScene);
        }
    }

}
