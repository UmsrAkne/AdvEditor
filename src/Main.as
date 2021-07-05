package {
    import flash.display.Sprite;
    import classes.gameScenes.ScenarioScene;
    import flash.display.StageScaleMode;
    import flash.display.StageAlign;
    import classes.gameScenes.LoadingScene;
    import flash.events.Event;
    import flash.filesystem.File;
    import classes.sceneContents.Resource;
    import flash.display.Bitmap;
    import flash.display.BitmapData;

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

            addChild(new Bitmap(new BitmapData(stage.stageWidth, stage.stageHeight, false, 0x0)));

            loadingScene = new LoadingScene(new File(File.applicationDirectory.nativePath).resolvePath("../scenarios/sampleScenario"));
            loadingScene.load();
            loadingScene.addEventListener(Event.COMPLETE, loadCompleteEventHandler);
        }

        private function loadCompleteEventHandler(event:Event):void {
            var res:Resource = LoadingScene(event.target).getResource();

            stage.stageWidth = res.ScreenSize.width;
            stage.stageHeight = res.ScreenSize.height;
            stage.nativeWindow.width = res.ScreenSize.width + 16;
            stage.nativeWindow.height = res.ScreenSize.height + 39;

            scenarioScene = new ScenarioScene();
            scenarioScene.setResource(res);
            addChild(scenarioScene);
            stage.focus = scenarioScene;
        }
    }

}
