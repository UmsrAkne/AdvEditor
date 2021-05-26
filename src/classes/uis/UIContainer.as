package classes.uis {

    import flash.display.Sprite;
    import flash.text.TextField;
    import flash.display.Loader;
    import flash.geom.Rectangle;

    public class UIContainer extends Sprite {

        private var baseRect:Rectangle;
        private var textWindow:TextField = new TextField();
        private var textWindowImage:Loader;
        private var bitmapContainers:Vector.<BitmapContainer> = new Vector.<BitmapContainer>();
        private var bgmChannelWrapper:SoundChannelWrapper = new SoundChannelWrapper();

        public function get TextWindow():TextField {
            return textWindow;
        }

        public function set TextWindowImage(value:Loader):void {
            textWindowImage = value;
        }

        public function get BGMChannelWrapper():SoundChannelWrapper {
            return bgmChannelWrapper;
        }

        public function UIContainer() {
            addChild(textWindow);

            for (var i:int = 0; i < 4; i++) {
                var bmpContainer:BitmapContainer = new BitmapContainer(i);
                bitmapContainers.push(bmpContainer);
                addChild(bmpContainer);
            }
        }

        /**
         * 入力した Rectangle の幅、高さを考慮してUIを配置します。
         * @param baseRect
         */
        public function AlignUI(baseObjectRect:Rectangle):void {
            baseRect = baseObjectRect;

            textWindow.width = 500;
            textWindow.height = 150;
            textWindow.x = (baseRect.width / 2) - (textWindow.width / 2) * -1;
            textWindow.y = baseRect.height * 0.75;
        }

        public function getBitmapContainerFromIndex(index:int):BitmapContainer {
            return bitmapContainers[index];
        }
    }
}
