package tests.sceneParts {

    import classes.sceneParts.SEPlayer;
    import classes.uis.UIContainer;
    import classes.sceneContents.Scenario;
    import classes.sceneContents.SoundFile;
    import tests.sceneContents.DummySound;
    import tests.Assert;

    public class TestSEPlayer {
        public function TestSEPlayer() {
            testExecute();
        }

        private function testExecute():void {
            var sePlayer:SEPlayer = new SEPlayer();
            var ui:UIContainer = new UIContainer();
            sePlayer.setUI(ui);

            var scenario:Scenario = new Scenario();
            var dummySound:DummySound = new DummySound();
            scenario.SE = new SoundFile(null, dummySound);

            sePlayer.setScenario(scenario);
            sePlayer.execute();

            Assert.isTrue(dummySound.Playing);
            Assert.areEqual(dummySound.playCallCount, 1);

            sePlayer.setScenario(new Scenario());
            sePlayer.execute();

            Assert.isTrue(dummySound.Playing);
            Assert.areEqual(dummySound.playCallCount, 1); // 再生はコールされないはずなのでカウンターは 1 のまま

        }
    }
}
