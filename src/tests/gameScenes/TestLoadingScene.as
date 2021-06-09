package tests.gameScenes {

    import classes.gameScenes.LoadingScene;
    import flash.filesystem.File;
    import tests.Assert;
    import flash.events.Event;
    import classes.sceneContents.Resource;

    public class TestLoadingScene {
        public function TestLoadingScene() {
            loadTest();
        }

        private function loadTest():void {
            var appDirectory:File = new File(File.applicationDirectory.nativePath);
            var loadingScene:LoadingScene = new LoadingScene(appDirectory.resolvePath("../scenarios/sampleScenario"));
            loadingScene.addEventListener(Event.COMPLETE, function(e:Event):void {
                var res:Resource = LoadingScene(e.target).getResource();
                Assert.areEqual(res.scenarios.length, 3);
                Assert.areEqual(res.BGMs.length, 2);
                Assert.areEqual(res.SEs.length, 2);

                // ファイルの読み込みを伴うため、 テストのカウンターに回数は反映されない。
                // テスト失敗の場合、出力はある。
            });
            loadingScene.load();
        }
    }
}
