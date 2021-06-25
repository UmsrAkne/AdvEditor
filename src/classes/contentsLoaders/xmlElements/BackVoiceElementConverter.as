package classes.contentsLoaders.xmlElements {

    import classes.sceneContents.Scenario;
    import flash.filesystem.File;

    public class BackVoiceElementConverter implements IXMLElementConverter {

        private var sceneDirectory:File;

        public function BackVoiceElementConverter(sceneDirectory:File) {
            this.sceneDirectory = sceneDirectory;
        }

        public function get ElementName():String {
            return "backVoice";
        }

        public function convert(scenarioElement:XML, scenario:Scenario):void {
            throw new Error("Method not implemented.");
        }

        private function get Aliases():Vector.<String> {
            return new <String>[ElementName, "bgVoice", "backgroundVoice", "bVoice"];
        }
    }
}
