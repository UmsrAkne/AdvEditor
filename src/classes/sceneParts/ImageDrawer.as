package classes.sceneParts {
    import classes.sceneContents.Scenario;
    import classes.uis.UIContainer;
    import classes.sceneContents.ImageOrder;
    import classes.uis.BitmapContainer;

    public class ImageDrawer implements IScenarioSceneParts {

        private var needExecute:Boolean;
        private var bitmapContainer:BitmapContainer;
        private var currentOrders:Vector.<ImageOrder> = new Vector.<ImageOrder>();

        public function ImageDrawer(targetBitmapContainer:BitmapContainer) {
            bitmapContainer = targetBitmapContainer;
        }

        public function execute():void {
            throw new Error("Method not implemented.");
        }

        public function setScenario(scenario:Scenario):void {
            if (scenario.ImagerOrders.length == 0) {
                needExecute = false;
                return;
            }

            for each (var order:ImageOrder in scenario.ImagerOrders) {
                if (order.targetLayerIndex == bitmapContainer.LayerIndex) {
                    currentOrders.push(order);
                }
            }
        }

        public function setUI(ui:UIContainer):void {
            throw new Error("Method not implemented.");
        }
    }
}
