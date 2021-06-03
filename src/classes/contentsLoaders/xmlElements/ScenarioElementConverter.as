package classes.contentsLoaders.xmlElements {

    import classes.sceneContents.Scenario;

    public class ScenarioElementConverter implements IXMLElementConverter {

        private var child:XMLList;

        public function ScenarioElementConverter() {
        }

        public function get ElementName():String {
            return "scenario";
        }

        public function convert(scenarioElement:XML, scenario:Scenario):void {
        }
    }
}
