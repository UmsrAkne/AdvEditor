package {
    import classes.gameScenes.LoadingScene;
    import classes.gameScenes.ScenarioScene;
    import classes.gameScenes.SelectionScene;
    import classes.sceneContents.Resource;
    import flash.display.Bitmap;
    import flash.display.BitmapData;
    import flash.display.Sprite;
    import flash.display.StageAlign;
    import flash.display.StageScaleMode;
    import flash.events.Event;

    /**
     * ...
     * @author
     */
    public class Main extends Sprite {

        private var loadingScene:LoadingScene;
        private var selectionScene:SelectionScene;
        private var scenarioScene:ScenarioScene;

        public function Main() {
            stage.align = StageAlign.TOP_LEFT;
            stage.scaleMode = StageScaleMode.NO_SCALE;
            stage.color = 0x0;

            stage.nativeWindow.width = 1280;
            stage.nativeWindow.height = 720;

            addChild(new Bitmap(new BitmapData(stage.stageWidth, stage.stageHeight, false, 0x0)));

            selectionScene = SelectionScene(addChild(new SelectionScene()));
            selectionScene.addEventListener(Event.COMPLETE, sceneSelectedEventHandler);

            stage.focus = selectionScene;
        }

        private function sceneSelectedEventHandler(e:Event):void {
            selectionScene.removeEventListener(Event.COMPLETE, sceneSelectedEventHandler);
            removeChild(selectionScene);
            loadingScene = new LoadingScene(selectionScene.SelectedSceneDirectory);
            loadingScene.addEventListener(Event.COMPLETE, loadCompleteEventHandler);
            loadingScene.load();
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
