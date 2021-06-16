package tests.contentsLoaders.xmlElements {

    import classes.contentsLoaders.xmlElements.TextElementConverter;
    import classes.sceneContents.Scenario;
    import tests.Assert;

    public class TestTextElementConverter {
        public function TestTextElementConverter() {
            testExecute();
        }

        private function testExecute():void {
            var textElementConverter:TextElementConverter = new TextElementConverter();
            var xml1:XML = new XML("<scenario><text string=\"testText_testText\" textAddition=\"true\" /></scenario>");
            var scenario1:Scenario = new Scenario();
            textElementConverter.convert(xml1, scenario1);

            Assert.areEqual(scenario1.Text, "testText_testText");
            Assert.isTrue(scenario1.TextAddition);

            var xml2:XML = new XML("<scenario><text string=\"testText_testText\" textAddition=\"false\" /></scenario>");
            var scenario2:Scenario = new Scenario();
            textElementConverter.convert(xml2, scenario2);
            Assert.isFalse(scenario2.TextAddition);

            var xml3:XML = new XML("<scenario><text string=\"testText_testText\" /></scenario>");
            var scenario3:Scenario = new Scenario();
            textElementConverter.convert(xml3, scenario3);
            Assert.isFalse(scenario2.TextAddition);
        }
    }
}
