package classes.sceneParts {

    import classes.sceneContents.Scenario;
    import classes.uis.UIContainer;
    import classes.sceneContents.Resource;
    import classes.uis.BitmapContainer;
    import classes.sceneContents.LipOrder;
    import flash.utils.Dictionary;
    import flash.display.Sprite;
    import classes.uis.SoundChannelWrapper;
    import flash.events.Event;
    import classes.sceneContents.ImageOrder;
    import flash.display.BitmapData;
    import flash.geom.Point;
    import flash.geom.Rectangle;
    import classes.sceneContents.ImageFile;

    public class LipDrawer implements IScenarioSceneParts {

        // テスト用のフィールド
        public var lastDrawImageName:String;

        private var bitmapContainer:BitmapContainer;
        private var currentLipOrder:LipOrder;
        private var currentLipImageName:String;
        private var imageFilesByName:Dictionary
        private var lipOrdersByName:Dictionary;
        private var enterFrameEventDispatcher:Sprite = new Sprite();
        private var soundChannelWrapper:SoundChannelWrapper;
        private var peakArranger:PeakArranger = new PeakArranger();
        private var drawCount:int;
        private var drawingLocationByName:Dictionary;

        public function LipDrawer(targetBitmapContainer:BitmapContainer) {
            this.bitmapContainer = targetBitmapContainer;
        }

        public function execute():void {
        }

        public function setScenario(scenario:Scenario):void {
            if (scenario.ImageOrders.length == 0) {
                // 画像描画の命令が無い場合は、このクラスを動作させる必要はない
                return;
            }

            var order:ImageOrder;

            for each (var o:ImageOrder in scenario.ImageOrders) {
                if (o.targetLayerIndex == bitmapContainer.LayerIndex) {
                    order = o;
                    break;
                }
            }

            if (order == null) {
                return;
            }

            if (order.names.length >= 2 && order.names[2] != "") {
                var imageName:String = order.names[2];

                while (enterFrameEventDispatcher.hasEventListener(Event.ENTER_FRAME)) {
                    enterFrameEventDispatcher.removeEventListener(Event.ENTER_FRAME, enterFrameEventHandler);
                }

                currentLipOrder = lipOrdersByName[imageName.toString()];

                if (currentLipOrder != null) {
                    enterFrameEventDispatcher.addEventListener(Event.ENTER_FRAME, enterFrameEventHandler);
                }

                currentLipImageName = imageName;
            }
        }

        public function setUI(ui:UIContainer):void {
            soundChannelWrapper = ui.getVoiceChannelWrapperFromIndex(bitmapContainer.LayerIndex - 1);
        }

        public function setResource(res:Resource):void {
            imageFilesByName = res.ImageFilesByName;
            lipOrdersByName = res.LipOrdersByName;
            drawingLocationByName = res.ImageDrawingPointByName;
        }

        public function dispose():void {
        }

        public function drawLip():void {
            if (currentLipOrder == null) {
                return;
            }

            var drawingImageNames:Vector.<String> = currentLipOrder.buildOrder();
            if (drawCount < drawingImageNames.length) {
                peakArranger.divisonCount = drawingImageNames.length - 1;
                var imageName:String = drawingImageNames[peakArranger.getLevel(soundChannelWrapper.getPeak())];
                var bd:BitmapData = ImageFile(imageFilesByName[imageName]).getBitmapData();
                var pos:Point = (drawingLocationByName[imageName] != null) ? drawingLocationByName[imageName] : new Point();
                bitmapContainer.Front.bitmapData.copyPixels(bd, new Rectangle(0, 0, bd.width, bd.height), pos, null, null, true);

                lastDrawImageName = imageName; // 単体テスト用の代入
                drawCount++;
            } else {
                drawCount = 0;
            }
        }

        private function enterFrameEventHandler(e:Event):void {
            drawLip();
        }
    }
}
