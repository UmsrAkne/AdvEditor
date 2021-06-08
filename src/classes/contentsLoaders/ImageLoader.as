package classes.contentsLoaders {

    import classes.sceneContents.Resource;
    import flash.filesystem.File;
    import flash.events.EventDispatcher;
    import flash.display.BitmapData;
    import flash.display.Loader;
    import flash.events.Event;
    import flash.net.URLRequest;

    public class ImageLoader implements ILoader {

        private var sceneDirectory:File;
        private var completeEventDispatcher:EventDispatcher = new EventDispatcher();
        private var loaders:Vector.<Loader> = new Vector.<Loader>();
        private var loadFileCount:int;

        private var imageFiles:Vector.<File>;
        private var bitmapDatas:Vector.<BitmapData>;

        public function ImageLoader(sceneDirectory:File) {
            this.sceneDirectory = sceneDirectory;
        }

        /**
         * resouce.BitmapDatas, resouce.BitmapDatasByName に、読み込んだ画像から生成した BitmapData を追加します。
         * BitmapDatasByName には、拡張子を含む名前と含まない名前の両方のキーでオブジェクトを追加します。
         * @param resource
         */
        public function writeContentsTo(resource:Resource):void {
            for (var i:int = 0; i < bitmapDatas.length; i++) {
                resource.BitmapDatas.push(bitmapDatas[i]);
                resource.BitmapDatasByName[imageFiles[i].name] = bitmapDatas[i]; // ファイル名全て
                resource.BitmapDatasByName[imageFiles[i].name.split(".")[0]] = bitmapDatas[i]; // 拡張子を除いたファイル名
            }
        }

        public function load():void {
            imageFiles = ContentsLoadUtil.getFileList(sceneDirectory.resolvePath("images").nativePath);

            if (imageFiles.length == 0) {

                // 通常、ロードを実行して読み込む画像ファイルが存在しないケースはあり得ないが、
                // イベントだけは送出しておかないと、ロード処理から先に進めなくなるため、
                // ファイルが無かった場合はメッセージだけ出して次に進めるようにする。

                completeEventDispatcher.dispatchEvent(new Event(Event.COMPLETE));
                trace("画像ファイルは読み込まれませんでした。");
            }

            loadFileCount = imageFiles.length

            for each (var f:File in imageFiles) {
                var l:Loader = new Loader();
                loaders.push(l);
                l.contentLoaderInfo.addEventListener(Event.COMPLETE, drawBitmaps);
                l.load(new URLRequest(f.nativePath));
            }
        }

        public function get CompleteEventDispatcher():EventDispatcher {
            return completeEventDispatcher;
        }

        /**
         * テスト用メソッド
         * @param value セット先が null の場合のみセット可能。
         */
        public function set ImageFiles(value:Vector.<File>):void {
            if (!imageFiles) {
                imageFiles = value;
            }
        }

        /**
         * テスト用メソッド
         * @param value セット先が null の場合のみセット可能。
         */
        public function set BitmapDatas(value:Vector.<BitmapData>):void {
            if (!bitmapDatas) {
                bitmapDatas = value;
            }
        }

        private function drawBitmaps(e:Event):void {
            loadFileCount--;
            if (loadFileCount == 0) {
                bitmapDatas = new Vector.<BitmapData>();

                for each (var l:Loader in loaders) {
                    var bd:BitmapData = new BitmapData(l.width, l.height, true, 0x0);
                    bd.draw(l);
                    bitmapDatas.push(bd);
                }

                completeEventDispatcher.dispatchEvent(new Event(Event.COMPLETE));
            }
        }
    }
}
