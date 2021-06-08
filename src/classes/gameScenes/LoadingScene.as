package classes.gameScenes {

    import flash.display.Sprite;
    import flash.filesystem.File;
    import classes.contentsLoaders.ILoader;

    public class LoadingScene extends Sprite {

        private var sceneDirectory:File;
        private var loaders:Vector.<ILoader> = new Vector.<ILoader>();

        public function LoadingScene(sceneDirectory:File) {
            this.sceneDirectory = sceneDirectory;
        }

        private function load():void {
        }

    }
}
