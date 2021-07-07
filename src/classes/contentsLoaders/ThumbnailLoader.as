package classes.contentsLoaders {
    import flash.events.EventDispatcher;
    import flash.filesystem.File;

    public class ThumbnailLoader {

        private var completeEventDispathcer:EventDispatcher = new EventDispatcher();
        private var sceneDirectory:File;

        public function ThumbnailLoader(sceneDirectory:File) {
            this.sceneDirectory = sceneDirectory;
        }

        public function load():void {
        }

        public function get CompleteEventDispatcher():EventDispatcher {
            return completeEventDispathcer;
        }
    }
}
