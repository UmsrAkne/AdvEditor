package tests.contentsLoaders {

    import classes.contentsLoaders.ScenarioLoader;
    import flash.filesystem.File;
    import flash.events.Event;
    import tests.Assert;
    import classes.sceneContents.Scenario;
    import classes.sceneContents.Resource;

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

            var completed:Boolean = false;
            scenarioLoader.CompleteEventDispatcher.addEventListener(Event.COMPLETE, function(e:Event):void {
                completed = true;
            });

            scenarioLoader.load();
            var res:Resource = new Resource();
            scenarioLoader.writeContentsTo(res);
            var v:Vector.<Scenario> = res.scenarios;

            Assert.areEqual(v.length, 2);
            Assert.isTrue(completed);
            Assert.areEqual(v[0].Voice.FileName, "testSound");
            Assert.areEqual(v[0].Text, "1testText1");
        }
    }
}
