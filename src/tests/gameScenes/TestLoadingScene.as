package tests.gameScenes {

    import classes.gameScenes.LoadingScene;
    import flash.filesystem.File;

    public class TestLoadingScene {
        public function TestLoadingScene() {
            loadTest();
        }

        private function loadTest():void {
            var loadingScene:LoadingScene = new LoadingScene(new File(File.applicationDirectory.nativePath));
        }
    }
}
