package classes.sceneParts {

    import classes.sceneContents.Scenario;
    import classes.uis.UIContainer;
    import classes.sceneContents.Resource;
    import classes.sceneContents.SoundFile;
    import flash.media.SoundTransform;
    import classes.uis.SoundChannelWrapper;

    public class BGMPlayer implements IScenarioSceneParts {

        private var currentSoundFile:SoundFile;
        private var soundChannelWrapper:SoundChannelWrapper;
        private var soundTransform:SoundTransform = new SoundTransform();

        public function BGMPlayer() {
        }

        public function execute():void {
            if (!currentSoundFile) {
                return;
            }

            if (soundChannelWrapper) {
                soundChannelWrapper.stop();
            }

            soundChannelWrapper.setSoundChannel(currentSoundFile.getSound().play(0, 999, soundTransform));
        }

        public function setScenario(scenario:Scenario):void {
            currentSoundFile = scenario.BGM;
        }

        public function setUI(ui:UIContainer):void {
            soundChannelWrapper = ui.BGMChannelWrapper;
        }

        public function setResource(res:Resource):void {
        }
    }
}
