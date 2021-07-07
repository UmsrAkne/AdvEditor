package classes.contentsLoaders {
    import flash.display.Loader;
    import flash.display.BitmapData;
    import flash.events.EventDispatcher;
    import flash.events.Event;
    import flash.filesystem.File;
    import flash.net.URLRequest;
    import flash.net.URLLoader;
    import flash.display.LoaderInfo;

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
            var setting:XMLList = new XMLList(URLLoader(e.target).data);
            var thumbnailFileName:String = setting["setting"][THUMBNAIL_ATTRIBUTE];

            var loader:Loader = new Loader();
            var thumbnailImageFile:File;
            if (thumbnailFileName != "") {
                thumbnailImageFile = sceneDirectory.resolvePath("images/" + thumbnailFileName);
            } else {
                thumbnailImageFile = ContentsLoadUtil.getFileList(sceneDirectory.resolvePath("images").nativePath)[0];
            }

            loader.contentLoaderInfo.addEventListener(Event.COMPLETE, function(e:Event):void {
                var l:Loader = LoaderInfo(e.target).loader;
                thumbnail = new BitmapData(l.width, l.height, false, 0x0);
                thumbnail.draw(l);

                CompleteEventDispatcher.dispatchEvent(new Event(Event.COMPLETE));
            });

            loader.load(new URLRequest(thumbnailImageFile.nativePath));
        }
    }
}
