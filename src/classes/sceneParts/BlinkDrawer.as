package classes.sceneParts {
    import classes.sceneContents.Scenario;
    import classes.sceneContents.Resource;
    import classes.uis.UIContainer;
    import classes.uis.BitmapContainer;

    public class BlinkDrawer implements IScenarioSceneParts {

        private var bitmapContainer:BitmapContainer;

        public function BlinkDrawer(targetBitmapContainer:BitmapContainer) {
            bitmapContainer = targetBitmapContainer;
        }

        public function execute():void {
            throw new Error("Method not implemented.");
        }

        public function setScenario(scenario:Scenario):void {
            throw new Error("Method not implemented.");
        }

        public function setUI(ui:UIContainer):void {
        }

        public function setResource(res:Resource):void {
        }
    }
}
