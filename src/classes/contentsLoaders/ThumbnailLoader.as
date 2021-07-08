package classes.contentsLoaders {
    import flash.display.Loader;
    import flash.display.BitmapData;
    import flash.events.EventDispatcher;
    import flash.events.Event;
    import flash.filesystem.File;
    import flash.net.URLRequest;
    import flash.net.URLLoader;
    import flash.display.LoaderInfo;
    import flash.geom.Rectangle;
    import flash.geom.Matrix;

    public class ThumbnailLoader {

        public static const DEFAULT_THUMBNAIL_WIDTH:int = 320;
        public static const DEFAULT_THUMBNAIL_HEIGHT:int = 160;

        private var completeEventDispathcer:EventDispatcher = new EventDispatcher();
        private var sceneDirectory:File;
        private var thumbnail:BitmapData;
        private var thumbnailRect:Rectangle = new Rectangle(0, 0, DEFAULT_THUMBNAIL_WIDTH, DEFAULT_THUMBNAIL_HEIGHT);
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
                createThumbnailImage(LoaderInfo(e.target).loader);
                CompleteEventDispatcher.dispatchEvent(new Event(Event.COMPLETE));
            });

            loader.load(new URLRequest(thumbnailImageFile.nativePath));
        }

        /**
         * thumbnailRect のサイズになるよう BitmapData を加工、生成して thumbnail に入力します。
         * @param loader
         */
        private function createThumbnailImage(loader:Loader):void {
            thumbnail = new BitmapData(thumbnailRect.width, thumbnailRect.height, false, 0x0);
            var m:Matrix = new Matrix();

            var scale:Number = thumbnailRect.width / loader.width;
            m.scale(scale, scale);
            m.ty -= (loader.height * scale / 2) - (thumbnailRect.height / 2);

            thumbnail.draw(loader, m, null, null);
        }
    }
}
