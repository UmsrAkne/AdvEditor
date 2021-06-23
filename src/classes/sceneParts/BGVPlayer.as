package classes.sceneParts {

    import classes.sceneContents.Scenario;
    import classes.uis.UIContainer;
    import classes.sceneContents.Resource;

    public class BGVPlayer implements IScenarioSceneParts {

        private var targetChannel:int;

        public function BGVPlayer(targetChannel:int) {
            this.targetChannel = targetChannel;
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
    }
}
