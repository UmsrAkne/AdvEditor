package classes.sceneParts {

    import classes.sceneContents.Scenario;
    import classes.uis.UIContainer;
    import classes.sceneContents.Resource;
    import classes.sceneContents.SoundFile;
    import flash.media.SoundTransform;
    import classes.uis.SoundChannelWrapper;
    import classes.sceneContents.StopOrder;

    public class BGMPlayer implements IScenarioSceneParts {

        private var currentSoundFile:SoundFile;
        private var soundChannelWrapper:SoundChannelWrapper;
        private var soundTransform:SoundTransform = new SoundTransform();
        private var stopRequest:Boolean;
        private var defaultVolume:Number = 1.0;

        public function BGMPlayer() {
        }

        public function execute():void {
            if (stopRequest) {
                stopRequest = false;
                soundChannelWrapper.stop();
            }

            if (!currentSoundFile) {
                return;
            }

            if (soundChannelWrapper) {
                soundChannelWrapper.stop();
            }

            soundChannelWrapper.setSoundChannel(currentSoundFile.getSound().play(0, 999, soundTransform));

            if (currentSoundFile.VolumeIsDefault) {
                soundChannelWrapper.Volume = defaultVolume;
            } else {
                soundChannelWrapper.Volume = currentSoundFile.Volume;
            }
        }

        public function setScenario(scenario:Scenario):void {
            currentSoundFile = scenario.BGM;

            for each (var order:StopOrder in scenario.StopOrders) {
                if (order.Target == "bgm") {
                    stopRequest = true;
                }
            }
        }

        public function setUI(ui:UIContainer):void {
            soundChannelWrapper = ui.BGMChannelWrapper;
        }

        public function setResource(res:Resource):void {
            defaultVolume = res.bgmVolume;
            if (res.InitialBGMName != "") {
                currentSoundFile = res.BGMsByName[res.InitialBGMName];
            }
        }

        public function dispose():void {
            soundChannelWrapper.stop();
        }
    }
}
