package classes.uis {

    import flash.display.Sprite;
    import flash.text.TextField;
    import flash.display.Loader;
    import flash.geom.Rectangle;
    import flash.display.Bitmap;
    import flash.display.BitmapData;
    import flash.text.TextFormat;
    import classes.sceneContents.movieClasses.MoviePlayerContainer;
    import classes.sceneContents.movieClasses.ExMoviePlayer;

    public class UIContainer extends Sprite {

        private var baseRect:Rectangle;
        private var textWindow:TextField = new TextField();
        private var textWindowImage:Bitmap = new Bitmap();
        private var debugTextWindow:TextField = new TextField()
        private var bitmapContainers:Vector.<BitmapContainer> = new Vector.<BitmapContainer>();
        private var moviePlayerContainers:Vector.<MoviePlayerContainer> = new Vector.<MoviePlayerContainer>();

        private var frame:Bitmap = new Bitmap();

        private var bgmChannelWrapper:SoundChannelWrapper = new SoundChannelWrapper();
        private var seChannelWrapper:SoundChannelWrapper = new SoundChannelWrapper();
        private var voiceChannelWrappers:Vector.<SoundChannelWrapper> = new Vector.<SoundChannelWrapper>();
        private var bgvChannelWrappers:Vector.<SoundChannelWrapper> = new Vector.<SoundChannelWrapper>();

        public function get TextWindow():TextField {
            return textWindow;
        }

        public function get DebugTextWindow():TextField {
            return debugTextWindow;
        }

        public function get TextWindowImage():Bitmap {
            return textWindowImage;
        }

        public function get BGMChannelWrapper():SoundChannelWrapper {
            return bgmChannelWrapper;
        }

        public function get SEChannelWrapper():SoundChannelWrapper {
            return seChannelWrapper;
        }

        public function UIContainer() {
            for (var i:int = 0; i < 4; i++) {
                var bmpContainer:BitmapContainer = new BitmapContainer(i);
                bitmapContainers.push(bmpContainer);
                addChild(bmpContainer);
            }

            var mpc:MoviePlayerContainer = new MoviePlayerContainer();
            moviePlayerContainers.push(mpc);
            addChild(mpc);

            addChild(textWindowImage);
            addChild(textWindow);
            addChild(frame);

            textWindow.defaultTextFormat = new TextFormat(null, 24, 0xffffff);
            textWindow.wordWrap = true;

            addChild(debugTextWindow);

            debugTextWindow.defaultTextFormat = new TextFormat(null, 18, 0x0);
            debugTextWindow.backgroundColor = 0xffffff;
            debugTextWindow.background = true;

            voiceChannelWrappers.push(new SoundChannelWrapper(), new SoundChannelWrapper(), new SoundChannelWrapper());
            bgvChannelWrappers.push(new SoundChannelWrapper(), new SoundChannelWrapper(), new SoundChannelWrapper());
        }

        /**
         * 入力した Rectangle の幅、高さを考慮してUIを配置します。
         * @param baseRect
         */
        public function AlignUI(baseObjectRect:Rectangle):void {
            baseRect = baseObjectRect;

            textWindow.width = Math.min(baseRect.width * 0.7, 600);
            textWindow.height = 150;
            textWindow.x = (baseRect.width / 2) - (textWindow.width / 2);
            textWindow.y = baseRect.height * 0.75;

            textWindowImage.x = (baseRect.width / 2) - (textWindowImage.width / 2);
            textWindowImage.y = baseRect.height * 0.7;
            textWindowImage.alpha = 0.5;

            debugTextWindow.width = 50;
            debugTextWindow.height = 20;
            debugTextWindow.x = (baseRect.width - debugTextWindow.width);
            debugTextWindow.alpha = 0.8;

            var mpc:MoviePlayerContainer = getMoviePlayerContainerFromIndex(0);
            mpc.setPlayers(new ExMoviePlayer(baseRect.width, baseRect.height), new ExMoviePlayer(baseRect.width, baseRect.height));

            var bgBmpContainer:BitmapContainer = getBitmapContainerFromIndex(0);
            bgBmpContainer.add(new Bitmap(new BitmapData(baseRect.width, baseRect.height, false, 0x0)));

            frame.bitmapData = new BitmapData(baseRect.width, baseRect.height, true, 0xFF000000);
            var frameWidth:int = 20;
            var frameHeight:int = 15
            frame.bitmapData.fillRect(new Rectangle(frameWidth, frameHeight, baseRect.width - frameWidth * 2, baseRect.height - frameHeight * 2), 0x00000000);
        }

        public function getBitmapContainerFromIndex(index:int):BitmapContainer {
            return bitmapContainers[index];
        }

        public function getMoviePlayerContainerFromIndex(index:int):MoviePlayerContainer {
            return moviePlayerContainers[index];
        }

        public function getVoiceChannelWrapperFromIndex(index:int):SoundChannelWrapper {
            return voiceChannelWrappers[index];
        }

        public function getBGVChannelWrapperFromIndex(index:int):SoundChannelWrapper {
            return bgvChannelWrappers[index];
        }

        public function dispose():void {
            while (numChildren > 0) {
                removeChild(getChildAt(numChildren - 1));
            }

            frame.bitmapData.dispose();
            frame = null;
            textWindowImage.bitmapData.dispose();
            textWindowImage = null;

            for each (var bc:BitmapContainer in bitmapContainers) {
                while (bc.numChildren > 0) {
                    var bmp:Bitmap = Bitmap(bc.getChildAt(bc.numChildren - 1));
                    bmp.bitmapData.dispose();
                    bc.removeChild(bmp);
                }
            }
        }
    }
}
