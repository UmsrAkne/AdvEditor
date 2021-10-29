package classes.contentsLoaders {

    import classes.sceneContents.Resource;
    import flash.filesystem.File;
    import flash.events.EventDispatcher;
    import flash.display.BitmapData;
    import flash.display.Loader;
    import flash.events.Event;
    import flash.net.URLRequest;
    import classes.sceneContents.ImageFile;
    import flash.utils.Dictionary;
    import classes.sceneContents.Scenario;
    import classes.sceneContents.ImageOrder;
    import classes.sceneContents.BlinkOrder;
    import classes.sceneContents.LipOrder;

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
            resource.BitmapDatas.push(new BitmapData(1, 1, true, 0));
            for (var i:int = 0; i < bitmapDatas.length; i++) {
                resource.BitmapDatas.push(bitmapDatas[i]);
                resource.BitmapDatasByName[imageFiles[i].name] = bitmapDatas[i]; // ファイル名全て
                resource.BitmapDatasByName[imageFiles[i].name.split(".")[0]] = bitmapDatas[i]; // 拡張子を除いたファイル名
            }

            resource.ImageFiles.push(new ImageFile(new File("/dummy")));
            for each (var f:File in imageFiles) {
                var imageFile:ImageFile = new ImageFile(f);
                resource.ImageFiles.push(imageFile);
                resource.ImageFilesByName[imageFile.FileName] = imageFile;
                resource.ImageFilesByName[imageFile.FileNameWithoutExtension] = imageFile;
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

            loadFileCount = imageFiles.length;

            for each (var f:File in imageFiles) {
                var l:Loader = new Loader();
                loaders.push(l);
                l.contentLoaderInfo.addEventListener(Event.COMPLETE, drawBitmaps);
                l.load(new URLRequest(f.nativePath));
            }
        }

        public function loadUsingImages(res:Resource):void {
            var usingImageNameDictionary:Object = new Object();

            // ImageOrder, DrawingOrder からシナリオで使用している画像の名前を抽出

            for each (var scn:Scenario in res.scenarios) {
                for each (var imageOrder:ImageOrder in scn.ImageOrders) {
                    for each (var n:String in imageOrder.names) {
                        usingImageNameDictionary[n] = n;
                    }
                }

                for each (imageOrder in scn.DrawingOrder) {
                    for each (n in imageOrder.names) {
                        usingImageNameDictionary[n] = n;
                    }
                }
            }

            // 表情制御に使用している画像のファイル名を抽出する。

            for each (var blinkOrder:BlinkOrder in res.BlinkOrdersByName) {
                usingImageNameDictionary[blinkOrder.BaseImageName] = blinkOrder.BaseImageName;
                usingImageNameDictionary[blinkOrder.CloseImageName] = blinkOrder.CloseImageName;
                for each (n in blinkOrder.buildOrder()) {
                    usingImageNameDictionary[n] = n;
                }
            }

            for each (var lipOrder:LipOrder in res.LipOrdersByName) {
                usingImageNameDictionary[lipOrder.BaseImageName] = lipOrder.BaseImageName;
                usingImageNameDictionary[lipOrder.CloseImageName] = lipOrder.CloseImageName;
                for each (n in lipOrder.buildOrder()) {
                    usingImageNameDictionary[n] = n;
                }
            }

            for each (var imageFileName:String in usingImageNameDictionary) {
                var targetFileName:String = usingImageNameDictionary[imageFileName];
                if (res.ImageFilesByName[targetFileName] != null) {
                    ImageFile(res.ImageFilesByName[usingImageNameDictionary[imageFileName]]).load();
                }
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
