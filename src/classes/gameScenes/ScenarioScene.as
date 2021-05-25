package classes.gameScenes {

    import flash.display.Sprite;
    import classes.uis.UIContainer;
    import classes.sceneParts.IScenarioSceneParts;
    import flash.events.KeyboardEvent;
    import flash.ui.Keyboard;
    import classes.sceneContents.Resource;
    import classes.sceneParts.TextWriter;

    public class ScenarioScene extends Sprite {

        private var ui:UIContainer = new UIContainer();
        private var sceneParts:Vector.<IScenarioSceneParts> = new Vector.<IScenarioSceneParts>();
        private var resource:Resource;
        private var scenarioCounter:int;

        public function ScenarioScene() {
            addChild(ui);
            addEventListener(KeyboardEvent.KEY_DOWN, keyboardEventHandler);

            sceneParts.push(new TextWriter());

            for each (var parts:IScenarioSceneParts in sceneParts) {
                parts.setUI(ui);
            }
        }

        public function setResource(r:Resource):void {
            if (resource == null) {
                resource = r;
            }
        }

        private function keyboardEventHandler(event:KeyboardEvent):void {
            if (event.keyCode == Keyboard.ENTER) {
                for each (var parts:IScenarioSceneParts in sceneParts) {
                    parts.setScenario(resource.scenarios[scenarioCounter])
                }

                for each (parts in sceneParts) {
                    parts.execute();
                }
            }
        }
    }
}
