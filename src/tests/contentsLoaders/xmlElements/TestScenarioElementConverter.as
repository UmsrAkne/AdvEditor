package tests.contentsLoaders.xmlElements {

    import classes.contentsLoaders.xmlElements.ScenarioElementConverter;
    import classes.sceneContents.Scenario;
    import tests.Assert;

    public class TestScenarioElementConverter {
        public function TestScenarioElementConverter() {
            testConvert();
        }

        private function testConvert():void {
            var scenarioElementConverter:ScenarioElementConverter = new ScenarioElementConverter();
            var xml1:XML = new XML("<scenario ignore=\"true\" ></scenario>");
            var xml2:XML = new XML("<scenario ignore=\"false\" ></scenario>");
            var xml3:XML = new XML("<scenario entryPoint=\"true\" chapterName=\"c1\" ></scenario>");

            var scenario1:Scenario = new Scenario();
            var scenario2:Scenario = new Scenario();
            var scenario3:Scenario = new Scenario();

            scenarioElementConverter.convert(xml1, scenario1);
            Assert.isTrue(scenario1.Ignore);

            scenarioElementConverter.convert(xml2, scenario2);
            Assert.isFalse(scenario2.Ignore);

            scenarioElementConverter.convert(xml3, scenario3);
            Assert.isTrue(scenario3.EntryPoint);
            Assert.areEqual(scenario3.ChapterName, "c1");
        }
    }
}
