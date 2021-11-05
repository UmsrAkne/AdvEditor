package {

    import flash.display.Sprite;
    import flash.display.StageAlign;
    import flash.display.StageScaleMode;
    import classes.gameScenes.ScenarioScene;
    import classes.gameScenes.SelectionScene;
    import classes.gameScenes.LoadingScene;
    import flash.events.Event;
    import classes.sceneContents.Resource;
    import flash.display.StageDisplayState;
    import flash.filesystem.File;
    import flash.net.URLLoader;
    import flash.net.URLRequest;

    public class FromLastScene extends Sprite {

        private var loadingScene:LoadingScene;
        private var selectionScene:SelectionScene;
        private var scenarioScene:ScenarioScene;

        public function FromLastScene() {
            stage.frameRate = 32;
            stage.align = StageAlign.TOP_LEFT;
            stage.scaleMode = StageScaleMode.NO_SCALE;
            stage.color = 0x0;
            stage.stageFocusRect = false;

            var appDirectory:File = new File(File.applicationDirectory.nativePath);

            var urlLoader:URLLoader = new URLLoader();
            urlLoader.addEventListener(Event.COMPLETE, function(e:Event):void {
                var xml:XML = new XML(URLLoader(e.target).data);
                var lastSelectedScenarioIndex:int = int(xml["configuration"]["@selectionIndex"]);

                if (xml["configuration"]["@fullScreenMode"] == "true") {
                    stage.displayState = StageDisplayState.FULL_SCREEN_INTERACTIVE;
                }

                var scenarioDirectories:Array = new File(appDirectory.resolvePath("../scenarios").nativePath).getDirectoryListing();

                loadingScene = new LoadingScene(scenarioDirectories[lastSelectedScenarioIndex]);
                loadingScene.addEventListener(Event.COMPLETE, loadCompleteEventHandler);
                loadingScene.load();
            });

            urlLoader.load(new URLRequest(new File(appDirectory.resolvePath("../commonResource/texts/configuration.xml").nativePath).nativePath));
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
