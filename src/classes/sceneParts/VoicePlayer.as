package classes.sceneParts {

    import classes.sceneContents.Scenario;
    import classes.sceneContents.Resource;
    import classes.uis.UIContainer;
    import classes.uis.SoundChannelWrapper;
    import classes.sceneContents.SoundFile;
    import classes.sceneContents.StopOrder;

    public class VoicePlayer implements IScenarioSceneParts {

        private var characterChannel:int;
        private var soundChannelWrapper:SoundChannelWrapper;
        private var voiceFile:SoundFile;
        private var stopRequest:Boolean;
        private var defaultVolume:Number = 1.0;

        /**
         * @param channelNumber このオブジェクトが担当する ChannelWrapper のインデックスを指定します。
         * 現在 0 - 2 の間で指定可能です。このインデックスは UIContainer.voiceChannelWrappers の内容とリンクしています。
         */
        public function VoicePlayer(channelNumber:int) {
            characterChannel = channelNumber;
        }

        public function execute():void {
            if (stopRequest) {
                soundChannelWrapper.stop();
                stopRequest = false;
            }

            if (voiceFile == null) {
                return;
            }

            soundChannelWrapper.stop();
            soundChannelWrapper.setSoundChannel(voiceFile.getSound().play());

            if (voiceFile.VolumeIsDefault) {
                soundChannelWrapper.Volume = defaultVolume;
            } else {
                soundChannelWrapper.Volume = voiceFile.Volume;
            }
        }

        public function setScenario(scenario:Scenario):void {
            voiceFile = scenario.Voice;

            for each (var order:StopOrder in scenario.StopOrders) {
                if (order.Target == "voice" && order.Index == characterChannel) {
                    stopRequest = true;
                }
            }
        }

        public function setUI(ui:UIContainer):void {
            soundChannelWrapper = ui.getVoiceChannelWrapperFromIndex(characterChannel);
        }

        public function setResource(res:Resource):void {
            defaultVolume = res.voiceVolume;
        }
    }
}
