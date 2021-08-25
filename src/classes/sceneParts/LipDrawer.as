package classes.sceneParts {

    import classes.sceneContents.Scenario;
    import classes.uis.UIContainer;
    import classes.sceneContents.Resource;
    import classes.uis.BitmapContainer;
    import classes.sceneContents.LipOrder;

    public class LipDrawer implements IScenarioSceneParts {

        private var bitmapContainer:BitmapContainer;
        private var currentLipOrder:LipOrder;


        public function LipDrawer(targetBitmapContainer:BitmapContainer) {
            this.bitmapContainer = targetBitmapContainer;
        }

        public function execute():void {
            throw new Error("Method not implemented.");
        }

        public function setScenario(scenario:Scenario):void {
            throw new Error("Method not implemented.");
        }

        public function setUI(ui:UIContainer):void {
            throw new Error("Method not implemented.");
        }

        public function setResource(res:Resource):void {
            throw new Error("Method not implemented.");
        }

        public function dispose():void {
            throw new Error("Method not implemented.");
        }
    }
}
