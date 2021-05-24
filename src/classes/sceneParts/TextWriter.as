package classes.sceneParts {

    import classes.sceneContents.Scenario;
    import classes.uis.UIContainer;
    import flash.text.TextField;
    import flash.events.EventDispatcher;
    import flash.events.Event;

    public class TextWriter extends EventDispatcher implements IScenarioSceneParts {

        private var currentText:String;
        private var textWindow:TextField;
        private var charaCounter:int;

        public function TextWriter() {
        }

        public function execute():void {
            if (hasEventListener(Event.ENTER_FRAME)) {
                textWindow.text = currentText;
                removeEventListener(Event.ENTER_FRAME, write);
            } else {
                textWindow.text = "";
                charaCounter = 0;
                addEventListener(Event.ENTER_FRAME, write);
            }
        }

        public function setScenario(scenario:Scenario):void {
            currentText = scenario.Text;
        }

        public function setUI(ui:UIContainer):void {
            textWindow = ui.TextWindow;
        }

        private function write(event:Event):void {
            if (currentText.length - 1 <= charaCounter) {
                charaCounter = 0;
                removeEventListener(Event.ENTER_FRAME, write);
            }

            textWindow.appendText(currentText.charAt(charaCounter));
            charaCounter++;
        }
    }
}
