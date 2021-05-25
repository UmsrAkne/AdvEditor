package classes.sceneParts {
    import classes.sceneContents.Scenario;
    import classes.uis.UIContainer;
    import classes.sceneContents.ImageOrder;
    import classes.uis.BitmapContainer;
    import flash.display.Bitmap;
    import flash.display.BitmapData;
    import classes.sceneContents.Resource;

    public class ImageDrawer implements IScenarioSceneParts {

        private var needExecute:Boolean;
        private var bitmapContainer:BitmapContainer;
        private var resource:Resource;
        private var currentOrder:ImageOrder

        public function ImageDrawer(targetBitmapContainer:BitmapContainer) {
            bitmapContainer = targetBitmapContainer;
        }

        public function execute():void {
            if (!needExecute) {
                return;
            }

            var bitmap:Bitmap = new Bitmap(new BitmapData(resource.screenSize.width, resource.screenSize.height, true));
            for each (var index:int in currentOrder.indexes) {
                if (index > 0) {
                    bitmap.bitmapData.draw(resource.imageLoaders[index]);
                }
            }

            bitmapContainer.add(bitmap);
            needExecute = false;
        }

        public function setScenario(scenario:Scenario):void {
            if (scenario.ImagerOrders.length == 0) {
                needExecute = false;
                return;
            }

            for each (var order:ImageOrder in scenario.ImagerOrders) {
                if (order.targetLayerIndex == bitmapContainer.LayerIndex) {
                    currentOrder = order;
                }
            }
        }

        public function setUI(ui:UIContainer):void {
            throw new Error("Method not implemented.");
        }

        public function setResource(res:Resource):void {
            this.resource = res;
        }
    }
}
