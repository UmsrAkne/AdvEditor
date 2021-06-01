package classes.contentsLoaders.xmlElements {

    import classes.sceneContents.Scenario;
    import flash.filesystem.File;

    public class SEElementConverter implements IXMLElementConverter {

        private var commonResourceDirectory:File;

        public function SEElementConverter(commonResourceDirectory:File) {
            this.commonResourceDirectory = commonResourceDirectory;
        }

        public function get ElementName():String {
            return "se"
        }

        public function convert(scenarioElement:XML, scenario:Scenario):void {
            throw new Error("Method not implemented.");
        }
    }
}
