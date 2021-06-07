package classes.contentsLoaders {

    import classes.sceneContents.Resource;
    import flash.filesystem.File;
    import flash.events.EventDispatcher;

    public class ImageLoader implements ILoader {

        private var sceneDirectory:File;
        private var completeEventDispatcher:EventDispatcher = new EventDispatcher();

        public function ImageLoader(sceneDirectory:File) {
            this.sceneDirectory = sceneDirectory;
        }

        public function writeContentsTo(resource:Resource):void {
        }

        public function load():void {
            var imageFiles:Vector.<File> = ContentsLoadUtil.getFileList(sceneDirectory.resolvePath("/images").nativePath);
            // loader による読み込み処理
        }

        public function get CompleteEventDispatcher():EventDispatcher {
            return completeEventDispatcher;
        }
    }
}
