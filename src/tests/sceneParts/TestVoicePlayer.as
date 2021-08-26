package tests.sceneParts {

    import classes.sceneParts.VoicePlayer;
    import classes.uis.UIContainer;
    import classes.sceneContents.Resource;
    import classes.sceneContents.Scenario;
    import classes.sceneContents.SoundFile;
    import tests.sceneContents.DummySound;
    import classes.uis.SoundChannelWrapper;
    import tests.Assert;

    public class TestVoicePlayer {
        public function TestVoicePlayer() {
            delayPlayTest();
        }

        private function delayPlayTest():void {
            var player:VoicePlayer = new VoicePlayer(0);
            var ui:UIContainer = new UIContainer();

            player.setUI(ui);
            player.setResource(new Resource());

            var scenario:Scenario = new Scenario();
            var v:SoundFile = new SoundFile(null, new DummySound());
            v.delay = 10;
            scenario.Voice = v;

            var played:Boolean;

            var scw:SoundChannelWrapper = ui.getVoiceChannelWrapperFromIndex(0)

            // サウンドチャンネルの置き換えイベントが出るのが、音声が再生されるタイミングであるため、
            // 音声が実際に再生されたかの判定はここで行う
            scw.addEventListener(SoundChannelWrapper.SOUND_CHANNEL_REPLACED, function():void {
                played = true;
            });

            player.setScenario(scenario);
            player.execute();

            for (var i:int = 0; i < 10; i++) {
                player.delayPlay();

                // 10回実行以内ではまだ再生されない
                Assert.isFalse(played);
            }

            // ここでのコールでサウンドチャンネルが置き換えられて再生される。
            player.delayPlay();
            Assert.isTrue(played);
        }
    }
}
