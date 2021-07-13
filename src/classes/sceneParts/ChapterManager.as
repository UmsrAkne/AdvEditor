package classes.sceneParts {

    import classes.sceneContents.Scenario;
    import classes.uis.UIContainer;
    import classes.sceneContents.Resource;

    public class ChapterManager implements IScenarioSceneParts {

        private var resource:Resource;
        private var lastPassedChapterName:String;
        private var currentChapterName:String;

        public function execute():void {
            throw new Error("Method not implemented.");
        }

        public function setScenario(scenario:Scenario):void {
        }

        public function setUI(ui:UIContainer):void {
        }

        public function setResource(res:Resource):void {
            if (resource == null) {
                resource = res;
            }
        }
    }
}
