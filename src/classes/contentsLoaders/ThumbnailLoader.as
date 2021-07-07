package classes.contentsLoaders {
    import flash.events.EventDispatcher;
    import flash.filesystem.File;
    import flash.net.URLRequest;
    import flash.net.URLLoader;
    import flash.events.Event;
    import flash.display.Loader;

    public class ThumbnailLoader {

        private var completeEventDispathcer:EventDispatcher = new EventDispatcher();
        private var sceneDirectory:File;

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

        private function xmlLoadComplete(e:Event):void {
            var loader:Loader = new Loader();
            var headerImageFile:File = ContentsLoadUtil.getFileList(sceneDirectory.resolvePath("images").nativePath)[0];

            loader.addEventListener(Event.COMPLETE, function(e:Event):void {
                CompleteEventDispatcher.dispatchEvent(new Event(Event.COMPLETE));
            });

            loader.load(new URLRequest(headerImageFile.nativePath));
        }
    }
}
