package classes.sceneParts {

    import classes.sceneContents.Scenario;
    import classes.uis.UIContainer;
    import flash.text.TextField;
    import flash.events.Event;
    import classes.sceneContents.Resource;
    import flash.display.Sprite;

    public class TextWriter extends Sprite implements IScenarioSceneParts {

        private var currentText:String;
        private var textWindow:TextField;
        private var charaCounter:int;
        private var saveText:Boolean;

        public function TextWriter() {
        }

        public function execute():void {
            if (hasEventListener(Event.ENTER_FRAME)) {
                textWindow.text = currentText;
                removeEventListener(Event.ENTER_FRAME, write);
            } else {
                if (!saveText) {
                    textWindow.text = "";
                }

                charaCounter = 0;
                addEventListener(Event.ENTER_FRAME, write);
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
                removeEventListener(Event.ENTER_FRAME, write);
                return;
            }

            textWindow.appendText(currentText.charAt(charaCounter));
            charaCounter++;
        }

        public function setResource(res:Resource):void {
            // Resource 使用の必要性が無いため実装無し。
        }

        public function get Writing():Boolean {
            return hasEventListener(Event.ENTER_FRAME);
        }
    }
}
