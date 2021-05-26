package classes.sceneParts {

    import classes.sceneContents.Scenario;
    import classes.uis.UIContainer;
    import classes.sceneContents.Resource;

    public class BGMPlayer implements IScenarioSceneParts {

        private var resource:Resource;

        public function BGMPlayer() {
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
            this.resource = res;
        }
    }
}
