package classes.sceneParts {
    import classes.sceneContents.Scenario;
    import classes.sceneContents.Resource;
    import classes.uis.UIContainer;
    import classes.uis.BitmapContainer;
    import flash.utils.Dictionary;
    import classes.sceneContents.ImageOrder;
    import flash.events.EventDispatcher;
    import flash.display.Sprite;
    import flash.events.Event;
    import classes.sceneContents.BlinkOrder;
    import flash.geom.Point;
    import flash.geom.Rectangle;
    import flash.display.BitmapData;

    public class BlinkDrawer implements IScenarioSceneParts {

        private var bitmapContainer:BitmapContainer;
        private var bitmapDatasByName:Dictionary;
        private var blinkOrdersByName:Dictionary;
        private var currentEyeImageName:String;
        private var currentBlinkOrder:BlinkOrder;
        private var drawingLocationByName:Dictionary;
        private var enterFrameEventDispatcher:EventDispatcher = new Sprite();
        private var interval:int = 90;
        private var drawCount:int;

        public function BlinkDrawer(targetBitmapContainer:BitmapContainer) {
            bitmapContainer = targetBitmapContainer;
        }

        public function execute():void {
        }

        public function setScenario(scenario:Scenario):void {
            if (scenario.ImagerOrders.length == 0) {
                return;
            }

            var order:ImageOrder;

            for each (var o:ImageOrder in scenario.ImagerOrders) {
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

                while (enterFrameEventDispatcher.hasEventListener(Event.ENTER_FRAME)) {
                    enterFrameEventDispatcher.removeEventListener(Event.ENTER_FRAME, drawBlink);
                }

                currentBlinkOrder = blinkOrdersByName[imageName.toString()];

                if (currentBlinkOrder != null) {
                    enterFrameEventDispatcher.addEventListener(Event.ENTER_FRAME, drawBlink);
                }

                currentEyeImageName = imageName;
            }
        }

        public function setUI(ui:UIContainer):void {
        }

        public function setResource(res:Resource):void {
            blinkOrdersByName = res.BlinkOrdersByName;
            bitmapDatasByName = res.BitmapDatasByName;
            drawingLocationByName = res.ImageDrawingPointByName;
        }

        /**
         * テスト用 getter
         * @return
         */
        public function get CurrentEyeImageName():String {
            return currentEyeImageName;
        }

        private function drawBlink(e:Event):void {
            interval--;
            if (interval > 0) {
                return;
            }

            var drawingImageNames:Vector.<String> = currentBlinkOrder.buildOrder();
            if (drawCount < drawingImageNames.length) {

                var imageName:String = drawingImageNames[drawCount];
                var bd:BitmapData = bitmapDatasByName[imageName];
                var pos:Point = (drawingLocationByName[imageName] != null) ? drawingLocationByName[imageName] : new Point();
                bitmapContainer.Front.bitmapData.copyPixels(bd, new Rectangle(0, 0, bd.width, bd.height), pos, null, null, true);
                drawCount++;
            } else {
                drawCount = 0;
                interval = Math.random() * 120;
            }
        }

        public function dispose():void {
        }
    }
}
