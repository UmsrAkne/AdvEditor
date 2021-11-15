package classes.sceneParts {

    import classes.sceneContents.Scenario;
    import classes.uis.UIContainer;
    import flash.text.TextField;
    import flash.events.Event;
    import classes.sceneContents.Resource;
    import flash.display.Sprite;

    public class TextWriter implements IScenarioSceneParts, IEnterFrameExecuter {

        private var currentText:String;
        private var textWindow:TextField;
        private var charaCounter:int;
        private var saveText:Boolean;
        private var enterFrameEventDispatcher:Sprite = new Sprite();
        private var scenarioCounter:int;
        private var writing:Boolean;

        public function TextWriter() {
        }

        public function execute():void {
            if (writing) {
                scenarioCounter++;
                textWindow.text = currentText;
                writing = false;
            } else {
                if (!saveText) {
                    textWindow.text = "";
                }

                charaCounter = 0;
                writing = true;
            }
        }

        public function setScenario(scenario:Scenario):void {
            currentText = scenario.Text;
            saveText = scenario.TextAddition;
        }

        public function setUI(ui:UIContainer):void {
            textWindow = ui.TextWindow;
        }

        private function write(event:Event):void {
        }

        public function setResource(res:Resource):void {
            // Resource 使用の必要性が無いため実装無し。
        }

        public function get ScenarioCounter():int {
            return scenarioCounter;
        }

        public function set ScenarioCounter(value:int):void {
            scenarioCounter = value;
            saveText = false;
        }

        public function dispatchEvent(e:Event):void {
            enterFrameEventDispatcher.dispatchEvent(e);
        }

        public function dispose():void {
        }

        public function executeOnEnterFrame():void {
            if (writing) {
                if (currentText.length <= charaCounter) {
                    charaCounter = 0;
                    scenarioCounter++;
                    writing = false;
                    return;
                }

                textWindow.appendText(currentText.charAt(charaCounter));
                charaCounter++;
            }
        }
    }
}
