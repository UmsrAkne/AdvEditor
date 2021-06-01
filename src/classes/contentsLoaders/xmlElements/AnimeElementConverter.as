package classes.contentsLoaders.xmlElements {

    import classes.sceneContents.Scenario;

    public class AnimeElementConverter implements IXMLElementConverter {
        public function AnimeElementConverter() {
        }

        public function get ElementName():String {
            return "anime";
        }

        public function convert(scenarioElement:XML, scenario:Scenario):void {
        }
    }
}
