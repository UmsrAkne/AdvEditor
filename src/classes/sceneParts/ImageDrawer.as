package classes.sceneParts {
    import classes.sceneContents.Scenario;
    import classes.uis.UIContainer;
    import classes.sceneContents.ImageOrder;
    import classes.uis.BitmapContainer;
    import flash.display.Bitmap;
    import flash.display.BitmapData;
    import classes.sceneContents.Resource;

    public class ImageDrawer implements IScenarioSceneParts {

        private var needBitmapAddition:Boolean;
        private var needBitmapDrawing:Boolean;

        private var bitmapContainer:BitmapContainer;
        private var resource:Resource;
        private var currentOrder:ImageOrder;
        private var drawingOrder:ImageOrder;

        public function ImageDrawer(targetBitmapContainer:BitmapContainer) {
            bitmapContainer = targetBitmapContainer;
        }

        public function execute():void {
            if (needBitmapAddition && needBitmapDrawing) {
                return;
            }

            var bitmap:Bitmap;

            if (needBitmapAddition) {
                bitmap = new Bitmap(new BitmapData(resource.screenSize.width, resource.screenSize.height, true));
                for each (var index:int in currentOrder.indexes) {
                    if (index > 0) {
                        bitmap.bitmapData.draw(resource.imageLoaders[index]);
                    }
                }

                bitmapContainer.add(bitmap);
            }

            if (needBitmapDrawing) {
                if (!bitmap) {

                    /** 画像の追加命令が同時に出ている場合は、bitmap に値が入っているので、そこにそのまま draw を実行する。 */

                    bitmap = bitmapContainer.Front;
                }

                for each (index in drawingOrder.indexes) {
                    if (index > 0) {
                        bitmap.bitmapData.draw(resource.imageLoaders[index]);
                    }
                }
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
    }
}
