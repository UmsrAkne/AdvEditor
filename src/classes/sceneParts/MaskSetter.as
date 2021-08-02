package classes.sceneParts {

    import classes.sceneContents.Scenario;
    import classes.uis.UIContainer;
    import classes.sceneContents.Resource;
    import classes.uis.BitmapContainer;
    import classes.sceneContents.MaskOrder;

    public class MaskSetter implements IScenarioSceneParts {

        private var bitmapContainer:BitmapContainer;
        private var maskOrder:MaskOrder;

        public function MaskSetter(targetBitmapContainer:BitmapContainer) {
            this.bitmapContainer = targetBitmapContainer;
        }

        public function execute():void {
            if (maskOrder == null) {
                return;
            }

            bitmapContainer.mask = maskOrder.shape;

            maskOrder = null;
        }

        public function setScenario(scenario:Scenario):void {
            for each (var mask:MaskOrder in scenario.Masks) {
                if (bitmapContainer.LayerIndex == mask.TargetLayerIndex) {
                    maskOrder = mask;
                    break;

                        // 一つの BitmapContainer に対して、複数のマスクを掛けるという状況はあり得ないため、
                        // 一つでも該当するマスクが見つかった場合はブレイクする。
                }
            }
        }

        public function setUI(ui:UIContainer):void {
        }

        public function setResource(res:Resource):void {
        }

        public function dispose():void {
        }
    }
}
