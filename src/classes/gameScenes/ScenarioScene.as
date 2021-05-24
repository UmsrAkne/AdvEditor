package classes.gameScenes {

    import flash.display.Sprite;
    import classes.uis.UIContainer;
    import classes.sceneParts.IScenarioSceneParts;
    import flash.events.KeyboardEvent;
    import flash.ui.Keyboard;

    public class ScenarioScene extends Sprite {

        private var ui:UIContainer = new UIContainer();
        private var sceneParts:Vector.<IScenarioSceneParts> = new Vector.<IScenarioSceneParts>();

        public function ScenarioScene() {
            addChild(ui);
            addEventListener(KeyboardEvent.KEY_DOWN, keyboardEventHandler);
        }

        private function keyboardEventHandler(event:KeyboardEvent):void {
            if (event.keyCode == Keyboard.ENTER) {
            }
        }
    }
}
