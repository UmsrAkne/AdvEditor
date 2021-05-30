package classes.contentsLoaders {

    import classes.sceneContents.Scenario;
    import flash.events.EventDispatcher;
    import flash.events.Event;
    import flash.display.Sprite;

    public class ScenarioLoader implements ILoader {

        private var scenarios:Vector.<Scenario> = new Vector.<Scenario>();
        private var completeEventDispatcher:Sprite = new Sprite();

        public function ScenarioLoader(filePath:String) {
        }

        public function getContents():* {
            return scenarios;
        }

        public function get CompleteEventDispatcher():EventDispatcher {
            return completeEventDispatcher;
        }
    }
}
        public function load():void {
            throw new Error("Method not implemented.");
        }

