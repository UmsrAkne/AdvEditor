package classes.sceneParts {
    import classes.sceneContents.Scenario;
    import classes.sceneContents.Resource;
    import classes.uis.UIContainer;
    import classes.uis.BitmapContainer;
    import flash.utils.Dictionary;
    import classes.sceneContents.ImageOrder;

    public class BlinkDrawer implements IScenarioSceneParts {

        private var bitmapContainer:BitmapContainer;
        private var blinkOrdersByName:Dictionary;
        private var currentEyeImageName:String;

        public function BlinkDrawer(targetBitmapContainer:BitmapContainer) {
            bitmapContainer = targetBitmapContainer;
        }

        public function execute():void {
            throw new Error("Method not implemented.");
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
                currentEyeImageName = order.names[1];
            }
        }

        public function setUI(ui:UIContainer):void {
        }

        public function setResource(res:Resource):void {
            blinkOrdersByName = res.BlinkOrdersByName;
        }

        /**
         * テスト用 getter
         * @return
         */
        public function get CurrentEyeImageName():String {
            return currentEyeImageName;
        }
    }
}
