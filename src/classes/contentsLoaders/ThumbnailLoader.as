package classes.contentsLoaders {
    import flash.display.Loader;
    import flash.display.BitmapData;
    import flash.events.EventDispatcher;
    import flash.events.Event;
    import flash.filesystem.File;
    import flash.net.URLRequest;
    import flash.net.URLLoader;

    public class ThumbnailLoader {

        private var completeEventDispathcer:EventDispatcher = new EventDispatcher();
        private var sceneDirectory:File;
        private var thumbnail:BitmapData;
        private const THUMBNAIL_ATTRIBUTE:String = "@thumbnail";

        public function ThumbnailLoader(sceneDirectory:File) {
            this.sceneDirectory = sceneDirectory;
        }

        public function load():void {
            var urlLoader:URLLoader = new URLLoader();
            urlLoader.addEventListener(Event.COMPLETE, xmlLoadComplete);
            urlLoader.load(new URLRequest(sceneDirectory.resolvePath("texts/setting.xml").nativePath));
        }

        public function get CompleteEventDispatcher():EventDispatcher {
            return completeEventDispathcer;
        }

        public function get Thumbnail():BitmapData {
            return thumbnail;
        }

        private function xmlLoadComplete(e:Event):void {
            var setting:XMLList = XMLList(e.target);
            var thumbnailFileName:String;
            if (setting.hasOwnProperty(THUMBNAIL_ATTRIBUTE)) {
                thumbnailFileName = setting[THUMBNAIL_ATTRIBUTE];
            }

            var loader:Loader = new Loader();
            var thumbnailImageFile:File;
            if (thumbnailFileName != "") {
                thumbnailImageFile = ContentsLoadUtil.getFileList(sceneDirectory.resolvePath("images").nativePath)[0];
            } else {
                thumbnailImageFile = sceneDirectory.resolvePath("images/" + thumbnailFileName);
            }

            loader.contentLoaderInfo.addEventListener(Event.COMPLETE, function(e:Event):void {
                CompleteEventDispatcher.dispatchEvent(new Event(Event.COMPLETE));
                var l:Loader = Loader(e.target);
                thumbnail = new BitmapData(l.width, l.height, false, 0x0);
                thumbnail.draw(l);
            });

            loader.load(new URLRequest(thumbnailImageFile.nativePath));
        }
    }
}
