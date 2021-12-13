package classes.sceneParts {

    import classes.sceneContents.ImageFile;
    import classes.sceneContents.ImageOrder;
    import classes.sceneContents.LipOrder;
    import classes.sceneContents.Resource;
    import classes.sceneContents.Scenario;
    import classes.uis.BitmapContainer;
    import classes.uis.SoundChannelWrapper;
    import classes.uis.UIContainer;
    import flash.display.BitmapData;
    import flash.events.Event;
    import flash.geom.Point;
    import flash.geom.Rectangle;
    import flash.utils.Dictionary;

    public class LipDrawer implements IScenarioSceneParts, IEnterFrameExecuter {

        // テスト用のフィールド
        public var lastDrawImageName:String;

        private var bitmapContainer:BitmapContainer;
        private var currentLipOrder:LipOrder;
        private var currentLipImageName:String;
        private var imageFilesByName:Dictionary
        private var lipOrdersByName:Dictionary;
        private var soundChannelWrapper:SoundChannelWrapper;
        private var peakArranger:PeakArranger = new PeakArranger();
        private var drawCount:int;
        private var drawingLocationByName:Dictionary;
        private var drawing:Boolean;

        public function LipDrawer(targetBitmapContainer:BitmapContainer) {
            this.bitmapContainer = targetBitmapContainer;
        }

        public function execute():void {
        }

        public function setScenario(scenario:Scenario):void {
            if (scenario.ImageOrders.length == 0 && scenario.ImageOrders.length == 0) {
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

            // imageOrder, DrawingOrder の両方にオーダーが入っていた場合、 order は上書きされるが問題ない。
            // 描画対象の優先順位は Image < Drawing 

            for each (o in scenario.DrawingOrder) {
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

                drawing = false;
                currentLipOrder = lipOrdersByName[imageName.toString()];

                if (currentLipOrder != null) {
                    drawing = true;
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

        public function executeOnEnterFrame():void {
            if (drawing) {
                drawLip();
            }
        }
    }
}
