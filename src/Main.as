package {
    import classes.gameScenes.LoadingScene;
    import classes.gameScenes.ScenarioScene;
    import classes.gameScenes.SelectionScene;
    import classes.sceneContents.Resource;
    import flash.display.Sprite;
    import flash.display.StageAlign;
    import flash.display.StageScaleMode;
    import flash.events.Event;
    import flash.display.StageDisplayState;

    /**
     * ...
     * @author
     */
    public class Main extends Sprite {

        private var loadingScene:LoadingScene;
        private var selectionScene:SelectionScene;
        private var scenarioScene:ScenarioScene;

        public function Main() {
            stage.frameRate = 32;
            stage.align = StageAlign.TOP_LEFT;
            stage.scaleMode = StageScaleMode.NO_SCALE;
            stage.color = 0x0;
            stage.stageFocusRect = false;

            stage.nativeWindow.width = 1280;
            stage.nativeWindow.height = 720;

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
            loadingScene.removeEventListener(Event.COMPLETE, loadCompleteEventHandler);

            var res:Resource = LoadingScene(event.target).getResource();

            if (stage.displayState != StageDisplayState.FULL_SCREEN_INTERACTIVE) {
                stage.stageWidth = res.ScreenSize.width;
                stage.stageHeight = res.ScreenSize.height;
                stage.nativeWindow.width = res.ScreenSize.width + 16;
                stage.nativeWindow.height = res.ScreenSize.height + 39;
            }

            stage.fullScreenSourceRect = res.ScreenSize;

            scenarioScene = new ScenarioScene();
            scenarioScene.setResource(res);
            scenarioScene.addEventListener(ScenarioScene.SCENE_EXIT, reloadScene);
            addChild(scenarioScene);
            stage.focus = scenarioScene;
        }

        private function reloadScene(e:Event):void {
            removeChild(scenarioScene);
            scenarioScene.removeEventListener(ScenarioScene.SCENE_EXIT, reloadScene);

            // 現在読み込まれているシーンの情報が欲しいので、上書き前にリソースを取り出す。
            var res:Resource = loadingScene.getResource();

            loadingScene = new LoadingScene(res.sceneDirectory);
            loadingScene.addEventListener(Event.COMPLETE, loadCompleteEventHandler);
            loadingScene.load();
        }
    }
}
