package classes.gameScenes {

    import flash.desktop.NativeApplication;
    import flash.display.Bitmap;
    import flash.display.BitmapData;
    import flash.display.Sprite;
    import flash.events.Event;
    import flash.events.KeyboardEvent;
    import flash.filesystem.File;
    import flash.geom.ColorTransform;
    import flash.geom.Matrix;
    import flash.geom.Rectangle;
    import flash.ui.Keyboard;
    import classes.contentsLoaders.ContentsLoadUtil;
    import classes.contentsLoaders.ThumbnailLoader;

    public class SelectionScene extends Sprite {

        private var thumbnails:Vector.<BitmapData> = new Vector.<BitmapData>();
        private var thumbnailLoaders:Vector.<ThumbnailLoader> = new Vector.<ThumbnailLoader>();
        private var canvas:Bitmap = new Bitmap(new BitmapData(ThumbnailLoader.DEFAULT_THUMBNAIL_WIDTH, ThumbnailLoader.DEFAULT_THUMBNAIL_HEIGHT * 5));
        private var contentsCounter:int;
        private var selectionIndex:int;

        public function SelectionScene() {
            var directories:Vector.<File> = ContentsLoadUtil.getFileList(new File(File.applicationDirectory.nativePath).resolvePath("../scenarios").nativePath);
            contentsCounter = directories.length;
            for each (var d:File in directories) {
                var thumbnailLoader:ThumbnailLoader = new ThumbnailLoader(d);
                thumbnailLoaders.push(thumbnailLoader);
                thumbnailLoader.CompleteEventDispatcher.addEventListener(Event.COMPLETE, thumbnailLoadComplete);
                thumbnailLoader.load();
            }
        }

        public function get SelectedSceneDirectory():File {
            return thumbnailLoaders[selectionIndex].SceneDirectory;
        }

        private function thumbnailLoadComplete(e:Event):void {
            contentsCounter--;
            if (contentsCounter <= 0) {
                for each (var tl:ThumbnailLoader in thumbnailLoaders) {
                    thumbnails.push(tl.Thumbnail);
                }

                addChild(canvas);
                addEventListener(KeyboardEvent.KEY_DOWN, keyboardEventHandler);
                drawThumbnails();
            }
        }

        private function keyboardEventHandler(e:KeyboardEvent):void {

            // enter でシーンを終了する。
            if (e.keyCode == Keyboard.ENTER) {
                dispatchEvent(new Event(Event.COMPLETE));
                removeEventListener(KeyboardEvent.KEY_DOWN, keyboardEventHandler);
                canvas.bitmapData.dispose();
            }

            if (e.keyCode == Keyboard.Q) {
                NativeApplication.nativeApplication.exit();
            }

            if (e.keyCode == Keyboard.DOWN) {
                if (selectionIndex >= thumbnailLoaders.length - 1) {
                    return;
                }

                selectionIndex++;
                drawThumbnails();
            }

            if (e.keyCode == Keyboard.UP) {
                if (selectionIndex <= 0) {
                    return;
                }

                selectionIndex--;
                drawThumbnails();
            }

            // 1ページ進む
            if (e.keyCode == Keyboard.RIGHT) {
                if (selectionIndex == thumbnailLoaders.length - 1) {
                    return;
                }

                selectionIndex = Math.min(selectionIndex + 5, thumbnailLoaders.length - 1);
                drawThumbnails();
            }

            // 1ページ戻る
            if (e.keyCode == Keyboard.LEFT) {
                if (selectionIndex <= 0) {
                    return;
                }

                selectionIndex = Math.max(selectionIndex - 5, 0);
                drawThumbnails();
            }
        }

        private function drawThumbnails():void {
            var drawingImages:Vector.<BitmapData> = new Vector.<BitmapData>();
            for (var i:int = 0; i < 5; i++) {
                var index:int = selectionIndex + i;
                if (index < 0 || index >= thumbnailLoaders.length) {
                    drawingImages.push(new BitmapData(ThumbnailLoader.DEFAULT_THUMBNAIL_WIDTH, ThumbnailLoader.DEFAULT_THUMBNAIL_HEIGHT, false, 0x0));
                } else {
                    drawingImages.push(thumbnailLoaders[index].Thumbnail.clone());
                }

                if (i != 0) {
                    var darkFilter:ColorTransform = new ColorTransform(0.4, 0.4, 0.4);
                    drawingImages[i].colorTransform(new Rectangle(0, 0, drawingImages[i].width, drawingImages[i].height), darkFilter);
                }
            }

            var posY:int = 0;
            for each (var b:BitmapData in drawingImages) {
                var m:Matrix = new Matrix();
                m.ty = posY * ThumbnailLoader.DEFAULT_THUMBNAIL_HEIGHT;
                canvas.bitmapData.draw(b, m);
                posY++;
            }
        }
    }
}
