package tests.contentsLoaders {

    import classes.contentsLoaders.ScenarioLoader;
    import flash.filesystem.File;
    import flash.events.Event;
    import tests.Assert;
    import classes.sceneContents.Scenario;

    public class TestScenarioLoader {
        public function TestScenarioLoader() {
            testLoad();
        }

        private function testLoad():void {
            var scenarioLoader:ScenarioLoader = new ScenarioLoader(new File(File.applicationDirectory.nativePath).resolvePath("../scenarios/sampleScenario"));

            var xmlString:String = "<root>";
            xmlString += "<scenario><voice fileName=\"testSound\" /><text string=\"1testText1\" /></scenario>";
            xmlString += "<scenario><text string=\"2testText2\" /></scenario>";
            xmlString += "</root>";

            scenarioLoader.ScenarioXML = new XMLList(xmlString);

            scenarioLoader.load();
            var v:Vector.<Scenario> = scenarioLoader.getContents();

            Assert.areEqual(v[0].Voice.FileName, "testSound");
        }
    }
}
