package classes.contentsLoaders.xmlElements {

    import classes.sceneContents.Scenario;

    public class TextElementConverter implements IXMLElementConverter {

        public static const STRING_ATTRIBUTE:String = "@string";
        public static const TEXT_ADDITION_ATTRIBUTE:String = "@textAddition";

        public function TextElementConverter() {
        }

        public function get ElementName():String {
            return "text";
        }

        public function convert(scenarioElement:XML, scenario:Scenario):void {
            if (!scenarioElement.hasOwnProperty(ElementName)) {
                return;
            }

            var textTag:XML = scenarioElement[ElementName][0];
            scenario.Text = textTag[STRING_ATTRIBUTE];

            if (textTag.hasOwnProperty(TEXT_ADDITION_ATTRIBUTE)) {
                if (textTag[TEXT_ADDITION_ATTRIBUTE] == "true") {
                    scenario.TextAddition = true;
                }
            }
        }
    }
}
