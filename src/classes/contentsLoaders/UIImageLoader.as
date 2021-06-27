package classes.contentsLoaders {
    import classes.sceneContents.Resource;
    import flash.events.EventDispatcher;
    import flash.filesystem.File;
    import flash.display.Loader;
    import flash.net.URLRequest;
    import flash.events.Event;
    import flash.display.BitmapData;

    public class UIImageLoader implements ILoader {

        private var eventDispatcher:EventDispatcher = new EventDispatcher();
        private var commonResourceDirectory:File;
        private var loadContentsCount:int;
        private var loaderByFileName:Object = new Object();

        public function UIImageLoader(commonResourceDirectory:File) {
            this.commonResourceDirectory = commonResourceDirectory;
        }

        public function writeContentsTo(resource:Resource):void {
            var txWindowImageLoader:Loader = Loader(loaderByFileName["textWindowImage.png"]);
            var txWindowImageData:BitmapData = new BitmapData(txWindowImageLoader.width, txWindowImageLoader.height, true, 0x0);
            txWindowImageData.draw(txWindowImageLoader);
            resource.UIImageContainer.TextWindowImage.bitmapData = txWindowImageData;
        }

        public function load():void {
            var imageFiles:Vector.<File> = ContentsLoadUtil.getFileList(commonResourceDirectory.resolvePath("images").nativePath);
            loadContentsCount = imageFiles.length;

            for each (var f:File in imageFiles) {
                var l:Loader = new Loader();
                l.contentLoaderInfo.addEventListener(Event.COMPLETE, loadCompleteEventHandler);
                l.load(new URLRequest(f.nativePath));
                loaderByFileName[f.name] = l;
            }
        }

        public function get CompleteEventDispatcher():EventDispatcher {
            return eventDispatcher;
        }

        private function loadCompleteEventHandler(e:Event):void {
            loadContentsCount--;

            if (loadContentsCount == 0) {
                eventDispatcher.dispatchEvent(new Event(Event.COMPLETE));
            }
        }
    }
}
