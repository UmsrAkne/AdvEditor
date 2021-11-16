package classes.sceneParts {
    import flash.display.BitmapData;
    import flash.events.Event;
    import flash.geom.Point;
    import flash.geom.Rectangle;
    import flash.utils.Dictionary;
    import classes.sceneContents.BlinkOrder;
    import classes.sceneContents.ImageFile;
    import classes.sceneContents.ImageOrder;
    import classes.sceneContents.Resource;
    import classes.sceneContents.Scenario;
    import classes.uis.BitmapContainer;
    import classes.uis.UIContainer;

    public class BlinkDrawer implements IScenarioSceneParts, IEnterFrameExecuter {

        private var bitmapContainer:BitmapContainer;
        private var imageFilesByName:Dictionary;
        private var blinkOrdersByName:Dictionary;
        private var currentEyeImageName:String;
        private var currentBlinkOrder:BlinkOrder;
        private var drawingLocationByName:Dictionary;
        private var interval:int = 90;
        private var drawCount:int;
        private var drawing:Boolean;

        public function BlinkDrawer(targetBitmapContainer:BitmapContainer) {
            bitmapContainer = targetBitmapContainer;
        }

        public function execute():void {
        }

        public function setScenario(scenario:Scenario):void {
            if (scenario.ImageOrders.length == 0) {
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

            if (order.names.length >= 2 && order.names[1] != "") {
                var imageName:String = order.names[1];

                drawing = false;
                currentBlinkOrder = blinkOrdersByName[imageName.toString()];

                if (currentBlinkOrder != null) {
                    drawing = true;
                }

                currentEyeImageName = imageName;
            }
        }

        public function setUI(ui:UIContainer):void {
        }

        public function setResource(res:Resource):void {
            blinkOrdersByName = res.BlinkOrdersByName;
            imageFilesByName = res.ImageFilesByName;
            drawingLocationByName = res.ImageDrawingPointByName;
        }

        /**
         * テスト用 getter
         * @return
         */
        public function get CurrentEyeImageName():String {
            return currentEyeImageName;
        }

        public function dispose():void {
        }

        public function executeOnEnterFrame():void {
            if (drawing) {
                interval--;
                if (interval > 0) {
                    return;
                }

                var drawingImageNames:Vector.<String> = currentBlinkOrder.buildOrder();
                if (drawCount < drawingImageNames.length) {

                    var imageName:String = drawingImageNames[drawCount];
                    var bd:BitmapData = ImageFile(imageFilesByName[imageName]).getBitmapData();
                    var pos:Point = (drawingLocationByName[imageName] != null) ? drawingLocationByName[imageName] : new Point();
                    bitmapContainer.Front.bitmapData.copyPixels(bd, new Rectangle(0, 0, bd.width, bd.height), pos, null, null, true);
                    drawCount++;
                } else {
                    drawCount = 0;
                    interval = Math.random() * 120;
                }
            }
        }
    }
}
