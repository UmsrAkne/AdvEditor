package classes.sceneParts {

    import classes.sceneContents.Scenario;
    import classes.uis.UIContainer;
    import classes.sceneContents.Resource;
    import classes.uis.SoundChannelWrapper;
    import classes.sceneContents.SoundFile;
    import flash.media.SoundTransform;
    import classes.sceneContents.StopOrder;

    public class SEPlayer implements IScenarioSceneParts {

        private var soundChannelWrapper:SoundChannelWrapper;
        private var soundFile:SoundFile;
        private var soundTransform:SoundTransform;
        private var repeatCount:int;
        private var stopRequest:Boolean;

        public function SEPlayer() {
        }

        public function execute():void {
            if (stopRequest) {
                soundChannelWrapper.stop();
                stopRequest = false;
            }

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

            for each (var order:StopOrder in scenario.StopOrders) {
                if (order.Target == "se") {
                    stopRequest = true;
                }
            }
        }

        public function setUI(ui:UIContainer):void {
            soundChannelWrapper = ui.SEChannelWrapper;
        }

        public function setResource(res:Resource):void {
            // 実装なし
        }
    }
}
