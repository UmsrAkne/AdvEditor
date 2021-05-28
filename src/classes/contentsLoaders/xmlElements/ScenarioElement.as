package classes.contentsLoaders.xmlElements {

    public class ScenarioElement implements IXMLElement {

        private var attributes:Vector.<String> = new Vector.<String>();
        private var child:XMLList;

        public function ScenarioElement(xmlList:XMLList) {
            attributes.push("@ignore");
            child = xmlList;
        }

        public function get ElementName():String {
            return "scenario";
        }

        public function get AttributeNames():Vector.<String> {
            return attributes;
        }

        public function convert():* {
            return child;
        }
    }
}
