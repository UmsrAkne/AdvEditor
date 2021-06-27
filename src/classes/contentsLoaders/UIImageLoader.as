package classes.contentsLoaders {
    import classes.sceneContents.Resource;
    import flash.events.EventDispatcher;
    import flash.filesystem.File;

    public class UIImageLoader implements ILoader {

        private var eventDispatcher:EventDispatcher = new EventDispatcher();
        private var commonResourceDirectory:File;

        public function UIImageLoader(commonResourceDirectory:File) {
            this.commonResourceDirectory = commonResourceDirectory;
        }

        public function writeContentsTo(resource:Resource):void {
        }

        public function load():void {
        }

        public function get CompleteEventDispatcher():EventDispatcher {
            return eventDispatcher;
        }
    }
}
