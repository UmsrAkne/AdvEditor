package classes.contentsLoaders.xmlElements {

    import classes.sceneContents.Scenario;

    public class TextElementConverter implements IXMLElementConverter {
        public function TextElementConverter() {
        }

        public function get ElementName():String {
            return "text";
        }

        public function convert(scenarioElement:XML, scenario:Scenario):void {
        }
    }
}
