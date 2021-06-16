package tests.sceneParts {

    import classes.sceneParts.BGMPlayer;
    import classes.uis.UIContainer;
    import classes.sceneContents.Scenario;
    import classes.sceneContents.SoundFile;
    import tests.sceneContents.DummySound;
    import tests.Assert;

    public class TestBGMPlayer {
        public function TestBGMPlayer() {
            testExecute();
        }

        private function testExecute():void {
            var player:BGMPlayer = new BGMPlayer();
            var ui:UIContainer = new UIContainer();
            player.setUI(ui);

            var scenario:Scenario = new Scenario();
            var dummySound:DummySound = new DummySound();
            scenario.BGM = new SoundFile(null, dummySound);
            player.setScenario(scenario);
            player.execute();

            // bgm は一回コールされて再生状態
            Assert.isTrue(dummySound.Playing);
            Assert.areEqual(dummySound.playCallCount, 1);

            player.setScenario(new Scenario());
            player.execute();

            // bgm 再生の指示が入っていないシナリオを入力。
            Assert.isTrue(dummySound.Playing);
            Assert.areEqual(dummySound.playCallCount, 1); // 再生はコールされないはずなのでカウンターは 1 のまま
        }
    }
}
