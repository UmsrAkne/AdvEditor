package classes.gameScenes {

    import classes.contentsLoaders.ContentsLoadUtil;
    import classes.contentsLoaders.ThumbnailLoader;
    import flash.desktop.NativeApplication;
    import flash.display.Bitmap;
    import flash.display.BitmapData;
    import flash.display.Screen;
    import flash.display.Sprite;
    import flash.display.StageDisplayState;
    import flash.events.Event;
    import flash.events.KeyboardEvent;
    import flash.filesystem.File;
    import flash.geom.ColorTransform;
    import flash.geom.Matrix;
    import flash.geom.Rectangle;
    import flash.text.TextField;
    import flash.text.TextFormat;
    import flash.ui.Keyboard;
    import flash.geom.Point;

    public class SelectionScene extends Sprite {

        private var thumbnails:Vector.<BitmapData> = new Vector.<BitmapData>();
        private var thumbnailLoaders:Vector.<ThumbnailLoader> = new Vector.<ThumbnailLoader>();
        private var canvas:Bitmap = new Bitmap();
        private var pathDisplayTextField:TextField = new TextField();
        private var contentsCounter:int;
        private var selectionIndex:int;
        private var drawingImageCapacity:int = 5;
        private var frameCount:int;
        private var scrollDirection:Point = new Point(0, 0);

        public function SelectionScene() {
            var directories:Vector.<File> = ContentsLoadUtil.getFileList(new File(File.applicationDirectory.nativePath).resolvePath("../scenarios").nativePath);
            contentsCounter = directories.length;
            for each (var d:File in directories) {
                var thumbnailLoader:ThumbnailLoader = new ThumbnailLoader(d);
                thumbnailLoaders.push(thumbnailLoader);
                thumbnailLoader.CompleteEventDispatcher.addEventListener(Event.COMPLETE, thumbnailLoadComplete);
                thumbnailLoader.load();
            }

            canvas.bitmapData = new BitmapData(ThumbnailLoader.DEFAULT_THUMBNAIL_WIDTH, ThumbnailLoader.DEFAULT_THUMBNAIL_HEIGHT * drawingImageCapacity);
            addEventListener(Event.ADDED, showTextField);
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
                drawThumbnails(drawingImageCapacity);
                pathDisplayTextField.text = thumbnailLoaders[selectionIndex].SceneDirectory.nativePath;
            }
        }

        private function keyboardEventHandler(e:KeyboardEvent):void {
            if (hasEventListener(Event.ENTER_FRAME)) {
                return;
            }

            // enter でシーンを終了する。
            if (e.keyCode == Keyboard.ENTER) {
                addEventListener(Event.ENTER_FRAME, exitScene);
                removeEventListener(KeyboardEvent.KEY_DOWN, keyboardEventHandler);
                return;
            }

            if (e.keyCode == Keyboard.Q) {
                NativeApplication.nativeApplication.exit();
            }

            if (e.keyCode == Keyboard.F) {
                stage.fullScreenSourceRect = Screen.mainScreen.bounds;
                stage.displayState = StageDisplayState.FULL_SCREEN_INTERACTIVE;
                drawingImageCapacity = Math.ceil(Screen.mainScreen.bounds.height / ThumbnailLoader.DEFAULT_THUMBNAIL_HEIGHT);
                canvas.bitmapData = new BitmapData(ThumbnailLoader.DEFAULT_THUMBNAIL_WIDTH, ThumbnailLoader.DEFAULT_THUMBNAIL_HEIGHT * drawingImageCapacity);
                pathDisplayTextField.y = stage.stageHeight - pathDisplayTextField.height;
            }

            if (e.keyCode == Keyboard.DOWN) {
                if (selectionIndex >= thumbnailLoaders.length - 1) {
                    return;
                }

                selectionIndex++;
                scrollDirection.y++;
            }

            if (e.keyCode == Keyboard.UP) {
                if (selectionIndex <= 0) {
                    return;
                }

                selectionIndex--;
                scrollDirection.y--;
            }

            // 1ページ進む
            if (e.keyCode == Keyboard.RIGHT) {
                if (selectionIndex == thumbnailLoaders.length - 1) {
                    return;
                }

                selectionIndex = Math.min(selectionIndex + 5, thumbnailLoaders.length - 1);
                scrollDirection.x++;
            }

            // 1ページ戻る
            if (e.keyCode == Keyboard.LEFT) {
                if (selectionIndex <= 0) {
                    return;
                }

                selectionIndex = Math.max(selectionIndex - 5, 0);
                scrollDirection.x--;
            }

            if (selectionIndex >= 0 && selectionIndex <= thumbnailLoaders.length - 1) {
                pathDisplayTextField.text = thumbnailLoaders[selectionIndex].SceneDirectory.nativePath;
                addEventListener(Event.ENTER_FRAME, scrollAnimation);
            }
        }

        private function drawThumbnails(drawCount:int):void {
            var drawingImages:Vector.<BitmapData> = new Vector.<BitmapData>();

            // 真ん中の位置だけ明度を下げずにカーソルの位置を示すため、描画可能な画像の枚数から中心の画像の座標を算出
            var centerPos:int = Math.floor(drawCount / 2);

            for (var i:int = centerPos * -1; i < drawCount - centerPos; i++) {
                var index:int = selectionIndex + i;
                if (index < 0 || index >= thumbnailLoaders.length) {
                    drawingImages.push(new BitmapData(ThumbnailLoader.DEFAULT_THUMBNAIL_WIDTH, ThumbnailLoader.DEFAULT_THUMBNAIL_HEIGHT, false, 0x0));
                } else {
                    drawingImages.push(thumbnailLoaders[index].Thumbnail.clone());
                }

                if (i != 0) {
                    var darkFilter:ColorTransform = new ColorTransform(0.4, 0.4, 0.4);
                    var img:BitmapData = drawingImages[drawingImages.length - 1];
                    img.colorTransform(new Rectangle(0, 0, img.width, img.height), darkFilter);
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

        private function scrollAnimation(e:Event):void {
            if (frameCount > 1) {
                drawThumbnails(drawingImageCapacity);
                removeEventListener(Event.ENTER_FRAME, scrollAnimation);
                frameCount = 0;
                scrollDirection = new Point(0, 0);
                canvas.x = 0;
                canvas.y = 0;
                canvas.alpha = 1.0;
                return;
            }

            canvas.x += scrollDirection.x * 80 * -1;
            canvas.y += scrollDirection.y * 50 * -1;
            canvas.alpha -= 0.3;

            frameCount++;
        }

        private function showTextField(e:Event):void {
            addChild(pathDisplayTextField);
            pathDisplayTextField.defaultTextFormat = new TextFormat(null, 22, 0xffffff);
            pathDisplayTextField.width = 1000;
            pathDisplayTextField.height = 30;

            if (stage != null) {
                pathDisplayTextField.y = stage.stageHeight - pathDisplayTextField.height;
            }
        }

        private function exitScene(e:Event):void {
            canvas.alpha -= 0.2;
            pathDisplayTextField.alpha -= 0.2;
            if (canvas.alpha <= 0) {
                canvas.bitmapData.dispose();
                removeEventListener(Event.ENTER_FRAME, exitScene);
                dispatchEvent(new Event(Event.COMPLETE));
            }
        }
    }
}
