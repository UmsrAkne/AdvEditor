package classes.sceneParts {

    import classes.sceneContents.Scenario;
    import classes.uis.UIContainer;
    import classes.sceneContents.Resource;
    import flash.text.TextField;

    public class Debugger implements IEnterFrameExecuter, IScenarioSceneParts {

        private var textWindow:TextField;

        public function Debugger() {
        }

        public function executeOnEnterFrame():void {
        }

        public function execute():void {
        }

        public function setScenario(scenario:Scenario):void {
        }

        public function setUI(ui:UIContainer):void {
            textWindow = ui.DebugTextWindow;
        }

        public function setResource(res:Resource):void {
        }

        public function dispose():void {
        }
    }
}
