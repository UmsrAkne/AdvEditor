package classes.gameScenes {

    import flash.display.Sprite;
    import flash.display.BitmapData;
    import flash.events.Event;
    import flash.events.KeyboardEvent;
    import flash.filesystem.File;
    import classes.contentsLoaders.ContentsLoadUtil;
    import classes.contentsLoaders.ThumbnailLoader;

    public class SelectionScene extends Sprite {

        private var thumbnails:Vector.<BitmapData> = new Vector.<BitmapData>();
        private var thumbnailLoaders:Vector.<ThumbnailLoader> = new Vector.<ThumbnailLoader>();
        private var contentsCounter:int;

        public function SelectionScene() {
            var directories:Vector.<File> = ContentsLoadUtil.getFileList(File.applicationDirectory.resolvePath("../scenarios").nativePath);
            contentsCounter = directories.length;
            for each (var d:File in directories) {
                var thumbnailLoader:ThumbnailLoader = new ThumbnailLoader(d);
                thumbnailLoaders.push(thumbnailLoader);
                thumbnailLoader.CompleteEventDispatcher.addEventListener(Event.COMPLETE, thumbnailLoadComplete);
            }
        }

        private function thumbnailLoadComplete(e:Event):void {
            contentsCounter--;
            if (contentsCounter <= 0) {
                for each (var tl:ThumbnailLoader in thumbnailLoaders) {
                    thumbnails.push(tl.Thumbnail);
                }

                addEventListener(KeyboardEvent.KEY_DOWN, keyboardEventHandler);
            }
        }

        private function keyboardEventHandler(e:Event):void {
        }
    }
}
