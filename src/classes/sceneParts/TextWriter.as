package classes.sceneParts {

    import classes.sceneContents.Scenario;
    import classes.uis.UIContainer;
    import flash.text.TextField;
    import flash.events.Event;
    import classes.sceneContents.Resource;
    import flash.display.Sprite;

    public class TextWriter implements IScenarioSceneParts {

        private var currentText:String;
        private var textWindow:TextField;
        private var charaCounter:int;
        private var saveText:Boolean;
        private var enterFrameEventDispatcher:Sprite = new Sprite();
        private var scenarioCounter:int;

        public function TextWriter() {
        }

        public function execute():void {
            if (enterFrameEventDispatcher.hasEventListener(Event.ENTER_FRAME)) {
                scenarioCounter++;
                textWindow.text = currentText;
                enterFrameEventDispatcher.removeEventListener(Event.ENTER_FRAME, write);
            } else {
                if (!saveText) {
                    textWindow.text = "";
                }

                charaCounter = 0;
                enterFrameEventDispatcher.addEventListener(Event.ENTER_FRAME, write);
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
            if (currentText.length <= charaCounter) {
                charaCounter = 0;
                scenarioCounter++;
                enterFrameEventDispatcher.removeEventListener(Event.ENTER_FRAME, write);
                return;
            }

            textWindow.appendText(currentText.charAt(charaCounter));
            charaCounter++;
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
    }
}
