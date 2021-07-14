package tests.sceneParts {

    import classes.sceneParts.ChapterManager;
    import classes.sceneContents.Resource;
    import classes.sceneContents.Scenario;
    import tests.Assert;

    public class TestChapterManager {
        public function TestChapterManager() {
            testGetNextChapterIndex();
        }

        private function testGetNextChapterIndex():void {
            var chapterManager:ChapterManager = new ChapterManager();
            var res:Resource = new Resource();

            var scenarios:Vector.<Scenario> = new Vector.<Scenario>();
            scenarios.push(new Scenario(), new Scenario(), new Scenario(), new Scenario(), new Scenario());

            scenarios[1].ChapterName = "chap1";
            scenarios[2].ChapterName = "chap1";
            scenarios[3].ChapterName = "chap2";

            res.ChapterHeaderIndexByChapterName["chap1"] = 1;
            res.ChapterHeaderIndexByChapterName["chap2"] = 3;

            res.ScenariosByChapterName["chap1"] = new Vector.<Scenario>();
            res.ScenariosByChapterName["chap2"] = new Vector.<Scenario>();

            Vector.<Scenario>(res.ScenariosByChapterName["chap1"]).push(scenarios[1]);
            Vector.<Scenario>(res.ScenariosByChapterName["chap1"]).push(scenarios[2]);

            Vector.<Scenario>(res.ScenariosByChapterName["chap2"]).push(scenarios[3]);

            chapterManager.setResource(res);

            Assert.areEqual(chapterManager.getNextChapterIndex(), 1);

            chapterManager.setScenario(scenarios[0]);
            Assert.areEqual(chapterManager.getNextChapterIndex(), 1);

            chapterManager.setScenario(scenarios[1]);
            Assert.areEqual(chapterManager.getNextChapterIndex(), 3);
        }
    }
}
