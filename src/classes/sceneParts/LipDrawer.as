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

    public class LipDrawer implements IScenarioSceneParts {

        // テスト用のフィールド
        public var lastDrawImageName:String;

        private var bitmapContainer:BitmapContainer;
        private var currentLipOrder:LipOrder;
        private var currentLipImageName:String;
        private var bitmapDatasByName:Dictionary
        private var lipOrdersByName:Dictionary;
        private var enterFrameEventDispatcher:Sprite = new Sprite();
        private var soundChannelWrapper:SoundChannelWrapper;
        private var drawCount:int;

        public function LipDrawer(targetBitmapContainer:BitmapContainer) {
            this.bitmapContainer = targetBitmapContainer;
        }

        public function execute():void {
            throw new Error("Method not implemented.");
        }

        public function setScenario(scenario:Scenario):void {
            if (scenario.ImagerOrders.length == 0) {
                // 画像描画の命令が無い場合は、このクラスを動作させる必要はない
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
            bitmapDatasByName = res.BitmapDatasByName;
            lipOrdersByName = res.LipOrdersByName
        }

        public function dispose():void {
            throw new Error("Method not implemented.");
        }

        public function drawLip():void {
            if (currentLipOrder == null) {
                return;
            }

            var drawingImageNames:Vector.<String> = currentLipOrder.buildOrder();
            if (drawCount < drawingImageNames.length) {
                var imageName:String = drawingImageNames[drawCount];
                bitmapContainer.Front.bitmapData.draw(bitmapDatasByName[imageName]);
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
