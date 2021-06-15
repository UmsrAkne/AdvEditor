package classes.sceneParts {
    import classes.sceneContents.Scenario;
    import classes.uis.UIContainer;
    import classes.sceneContents.ImageOrder;
    import classes.uis.BitmapContainer;
    import flash.display.Bitmap;
    import flash.display.BitmapData;
    import classes.sceneContents.Resource;
    import flash.events.EventDispatcher;
    import flash.events.Event;
    import flash.geom.ColorTransform;
    import flash.display.Sprite;
    import flash.geom.Matrix;

    public class ImageDrawer implements IScenarioSceneParts {

        private var needBitmapAddition:Boolean;
        private var needBitmapDrawing:Boolean;

        private var bitmapContainer:BitmapContainer;
        private var resource:Resource;
        private var currentOrder:ImageOrder;
        private var drawingOrder:ImageOrder;
        private var totalDrawingDepth:Number = 0;
        private var lastSettingRotation:int = 0;

        private var enterFrameEventDispatcher:EventDispatcher = new Sprite();

        public function ImageDrawer(targetBitmapContainer:BitmapContainer) {
            bitmapContainer = targetBitmapContainer;
        }

        public function execute():void {
            if (!needBitmapAddition && !needBitmapDrawing) {
                return;
            }

            // 最初のガード節を抜けた時点で、新規か上書きのいずれかの画像描画命令が出ていることが確定。
            // どちらの場合であっても、 drawToFront(e:Event) が動作中では、ターゲットに不正な値が入るので、
            // stopDrawing() を使用して処理を停止させる。

            if (enterFrameEventDispatcher.hasEventListener(Event.ENTER_FRAME)) {
                stopDrawing();
            }

            if (needBitmapAddition) {
                var bitmap:Bitmap = new Bitmap(new BitmapData(resource.ScreenSize.width, resource.ScreenSize.height, true));
                for each (var index:int in currentOrder.indexes) {
                    if (index > 0) {
                        bitmap.bitmapData.draw(resource.BitmapDatas[index]);
                    }
                }

                var matrix:Matrix;

                if (currentOrder.statusInherit && bitmapContainer.Front != null) {
                    bitmap.scaleX = bitmapContainer.Front.scaleX;
                    bitmap.scaleY = bitmapContainer.Front.scaleY;
                    bitmap.x = bitmapContainer.Front.x;
                    bitmap.y = bitmapContainer.Front.y;

                    if (lastSettingRotation != 0) {
                        matrix = bitmap.transform.matrix;
                        matrix.translate(bitmap.width / 2 * -1, bitmap.height / 2 * -1);
                        matrix.rotate(lastSettingRotation * Math.PI / 180);
                        matrix.translate(bitmap.width / 2, bitmap.height / 2);
                        bitmap.transform.matrix = matrix;
                    }
                } else {
                    bitmap.scaleX = currentOrder.scale;
                    bitmap.scaleY = currentOrder.scale;
                    bitmap.x = currentOrder.x;
                    bitmap.y = currentOrder.y;

                    if (currentOrder.rotation != 0) {
                        matrix = bitmap.transform.matrix;
                        matrix.translate(bitmap.width / 2 * -1, bitmap.height / 2 * -1);
                        matrix.rotate(currentOrder.rotation * Math.PI / 180);
                        matrix.translate(bitmap.width / 2, bitmap.height / 2);
                        bitmap.transform.matrix = matrix;
                    }

                    lastSettingRotation = currentOrder.rotation;
                }

                bitmapContainer.add(bitmap);
            }

            if (needBitmapDrawing) {
                enterFrameEventDispatcher.addEventListener(Event.ENTER_FRAME, drawToFront);
            }

            needBitmapDrawing = false;
            needBitmapAddition = false;
        }

        public function setScenario(scenario:Scenario):void {
            if (scenario.ImagerOrders.length == 0 && scenario.DrawingOrder.length == 0) {
                needBitmapDrawing = false;
                needBitmapAddition = false;
                return;
            }

            if (scenario.ImagerOrders.length > 0) {
                for each (var order:ImageOrder in scenario.ImagerOrders) {
                    if (order.targetLayerIndex == bitmapContainer.LayerIndex) {
                        currentOrder = order;
                    }
                }

                needBitmapAddition = true;
            }

            if (scenario.DrawingOrder.length > 0) {
                for each (order in scenario.DrawingOrder) {
                    if (order.targetLayerIndex == bitmapContainer.LayerIndex) {
                        drawingOrder = order;
                    }
                }

                needBitmapDrawing = true;
            }
        }

        public function setUI(ui:UIContainer):void {
            // 実装無し
        }

        public function setResource(res:Resource):void {
            this.resource = res;
        }

        private function drawToFront(e:Event):void {
            var bitmap:Bitmap = bitmapContainer.Front;

            for each (var index:int in drawingOrder.indexes) {
                if (index > 0) {
                    bitmap.bitmapData.draw(resource.BitmapDatas[index], null, new ColorTransform(1, 1, 1, drawingOrder.drawingDepth));
                }
            }

            totalDrawingDepth += drawingOrder.drawingDepth;
            if (totalDrawingDepth >= 1.2) {
                stopDrawing();
            }
        }

        private function stopDrawing():void {
            while (enterFrameEventDispatcher.hasEventListener(Event.ENTER_FRAME)) {
                enterFrameEventDispatcher.removeEventListener(Event.ENTER_FRAME, drawToFront);
            }

            totalDrawingDepth = 0;

            var bitmap:Bitmap = bitmapContainer.Front;
            for each (var index:int in drawingOrder.indexes) {
                if (index > 0) {
                    bitmap.bitmapData.draw(resource.BitmapDatas[index]);
                }
            }
        }

        public function get EnterFrameEventDispatcher():EventDispatcher {
            return enterFrameEventDispatcher;
        }
    }
}
