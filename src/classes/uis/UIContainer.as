package classes.uis {

    import flash.display.Sprite;
    import flash.text.TextField;
    import flash.display.Loader;
    import flash.geom.Rectangle;
    import flash.display.Bitmap;
    import flash.display.BitmapData;
    import flash.text.TextFormat;

    public class UIContainer extends Sprite {

        private var baseRect:Rectangle;
        private var textWindow:TextField = new TextField();
        private var textWindowImage:Bitmap = new Bitmap();
        private var bitmapContainers:Vector.<BitmapContainer> = new Vector.<BitmapContainer>();

        private var frame:Bitmap = new Bitmap();

        private var bgmChannelWrapper:SoundChannelWrapper = new SoundChannelWrapper();
        private var seChannelWrapper:SoundChannelWrapper = new SoundChannelWrapper();
        private var voiceChannelWrappers:Vector.<SoundChannelWrapper> = new Vector.<SoundChannelWrapper>();
        private var bgvChannelWrappers:Vector.<SoundChannelWrapper> = new Vector.<SoundChannelWrapper>();

        public function get TextWindow():TextField {
            return textWindow;
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

            addChild(textWindowImage);
            addChild(textWindow);
            addChild(frame);

            textWindow.defaultTextFormat = new TextFormat(null, 24, 0xffffff);
            textWindow.wordWrap = true;

            voiceChannelWrappers.push(new SoundChannelWrapper(), new SoundChannelWrapper(), new SoundChannelWrapper());
            bgvChannelWrappers.push(new SoundChannelWrapper(), new SoundChannelWrapper(), new SoundChannelWrapper());
        }

        /**
         * 入力した Rectangle の幅、高さを考慮してUIを配置します。
         * @param baseRect
         */
        public function AlignUI(baseObjectRect:Rectangle):void {
            baseRect = baseObjectRect;

            textWindow.width = baseRect.width * 0.7;
            textWindow.height = 150;
            textWindow.x = (baseRect.width / 2) - (textWindow.width / 2);
            textWindow.y = baseRect.height * 0.75;

            textWindowImage.x = (baseRect.width / 2) - (textWindowImage.width / 2);
            textWindowImage.y = baseRect.height * 0.7;

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

        public function getVoiceChannelWrapperFromIndex(index:int):SoundChannelWrapper {
            return voiceChannelWrappers[index];
        }

        public function getBGVChannelWrapperFromIndex(index:int):SoundChannelWrapper {
            return bgvChannelWrappers[index];
        }
    }
}
