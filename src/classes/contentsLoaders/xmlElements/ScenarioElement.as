package classes.contentsLoaders.xmlElements {

    import classes.sceneContents.Scenario;

    public class ScenarioElement implements IXMLElementConverter {

        private var child:XMLList;

        public function ScenarioElement() {
        }

        public function get ElementName():String {
            return "scenario";
        }

        public function convert(scenarioElement:XML, scenario:Scenario):void {
        }
    }
}
