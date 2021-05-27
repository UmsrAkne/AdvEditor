package classes.sceneParts {

    import classes.sceneContents.Scenario;
    import classes.uis.UIContainer;
    import classes.sceneContents.Resource;
    import classes.uis.SoundChannelWrapper;
    import classes.sceneContents.SoundFile;
    import flash.media.SoundTransform;

    public class SEPlayer implements IScenarioSceneParts {

        private var soundChannelWrapper:SoundChannelWrapper;
        private var soundFile:SoundFile;
        private var soundTransform:SoundTransform;
        private var repeatCount:int;

        public function SEPlayer() {
        }

        public function execute():void {
            if (!soundFile) {
                return;
            }

            if (soundChannelWrapper) {
                soundChannelWrapper.stop();
            }

            soundChannelWrapper.setSoundChannel(soundFile.getSound().play(0, repeatCount, soundTransform));
            repeatCount = 0;
        }

        public function setScenario(scenario:Scenario):void {
            soundFile = scenario.SE;
            repeatCount = scenario.SERepeatCount;
        }

        public function setUI(ui:UIContainer):void {
            soundChannelWrapper = ui.SEChannelWrapper;
        }

        public function setResource(res:Resource):void {
            // 実装なし
        }
    }
}
