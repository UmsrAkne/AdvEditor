package classes.sceneContents {

    import flash.display.BitmapData;
    import flash.display.Loader;
    import flash.display.LoaderInfo;
    import flash.events.Event;
    import flash.filesystem.File;
    import flash.net.URLRequest;

    public class ImageFile {

        private var bitmapData:BitmapData;
        private var file:File;

        public function get FileName():String {
            return file != null ? file.name : "";
        }

        public function get FileNameWithoutExtension():String {
            return file != null ? file.name.split(".")[0] : "";
        }

        public function ImageFile(imageFile:File) {
            file = imageFile;
        }

        public function load():void {
            if (bitmapData == null) {
                var l:Loader = new Loader();
                l.contentLoaderInfo.addEventListener(Event.COMPLETE, function(e:Event):void {
                    var loaderInfo:LoaderInfo = e.target as LoaderInfo;
                    bitmapData = new BitmapData(loaderInfo.width, loaderInfo.height, true, 0x0);
                });

                l.load(new URLRequest(file.nativePath));
            }
        }

        /**
         * 内部の bitmapData が null の場合にのみセット可能
         * @param b
         */
        public function setBitmapData(b:BitmapData):void {
            if (bitmapData == null) {
                bitmapData = b;
            }
        }
    }
}
