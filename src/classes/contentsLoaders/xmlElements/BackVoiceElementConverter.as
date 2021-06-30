package classes.contentsLoaders.xmlElements {

    import classes.sceneContents.Scenario;
    import flash.filesystem.File;
    import classes.sceneContents.BGVOrder;

    public class BackVoiceElementConverter implements IXMLElementConverter {

        public static const NAMES_ATTRIBUTE:String = "@names";
        public static const CHARACTER_CHANNEL_ATTRIBUTE:String = "@characterChannel";
        public static const VOLUME_ATTRIBUTE:String = "@volume";

        private var sceneDirectory:File;

        public function BackVoiceElementConverter(sceneDirectory:File) {
            this.sceneDirectory = sceneDirectory;
        }

        public function get ElementName():String {
            return "backVoice";
        }

        public function convert(scenarioElement:XML, scenario:Scenario):void {
            var elementNames:Vector.<String> = Aliases;
            var elementName:String
            for each (var eName:String in elementNames) {
                if (scenarioElement.hasOwnProperty(eName)) {
                    elementName = eName;
                }
            }

            if (elementName == "") {
                return;
            }

            for each (var tag:XML in scenarioElement[elementName]) {
                var bgvOrder:BGVOrder = new BGVOrder();

                if (tag.hasOwnProperty(CHARACTER_CHANNEL_ATTRIBUTE)) {
                    bgvOrder.CharacterChannel = parseInt(tag[CHARACTER_CHANNEL_ATTRIBUTE]);
                }

                if (tag.hasOwnProperty(NAMES_ATTRIBUTE)) {
                    var names:Array = String(tag[NAMES_ATTRIBUTE]).replace(/ /g, "").split(",");
                    for (var i:int = 0; i < names.length; i++) {
                        bgvOrder.Names.push(names[i]);
                    }
                }

                if (tag.hasOwnProperty(VOLUME_ATTRIBUTE)) {
                    if (!isNaN(parseFloat(tag[VOLUME_ATTRIBUTE]))) {
                        bgvOrder.Volume = parseFloat(tag[VOLUME_ATTRIBUTE]);
                    }
                }

                scenario.BGVOrders.push(bgvOrder);
            }
        }

        private function get Aliases():Vector.<String> {
            return new <String>[ElementName, "bgVoice", "backgroundVoice", "bVoice"];
        }
    }
}
