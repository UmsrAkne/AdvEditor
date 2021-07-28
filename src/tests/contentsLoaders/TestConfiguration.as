package tests.contentsLoaders {

    import classes.contentsLoaders.Configuration;
    import tests.Assert;

    public class TestConfiguration {
        public function TestConfiguration() {
            test();
            testInvalidXML();
        }

        private function test():void {
            var config:Configuration = new Configuration();

            Assert.areEqual(config.SelectionIndex, 0);
            Assert.isFalse(config.FullScreenMode);

            var xmlString:String = "<root><configuration ";
            xmlString += "selectionIndex=\"3\" ";
            xmlString += "fullScreenMode=\"true\" ";
            xmlString += "/></root>"

            config.setConfigrationXML(new XML(xmlString));

            Assert.areEqual(config.SelectionIndex, 3);
            Assert.isTrue(config.FullScreenMode);
        }

        private function testInvalidXML():void {
            var invalidXMLString:String = "<root><configuration selectionIndex=\"not number\" /></root>";
            var config:Configuration = new Configuration();

            config.setConfigrationXML(new XML(invalidXMLString));

            Assert.areEqual(config.SelectionIndex, 0);
        }
    }
}
