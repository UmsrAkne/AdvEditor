package classes.sceneParts {

    import classes.sceneContents.Scenario;
    import classes.sceneContents.Resource;
    import classes.uis.UIContainer;
    import classes.uis.SoundChannelWrapper;
    import classes.uis.BitmapContainer;
    import classes.sceneContents.SoundFile;
    import flash.utils.Dictionary;
    import flash.events.Event;
    import classes.sceneContents.BGVOrder;

    public class BGVPlayer implements IScenarioSceneParts {

        private var targetChannelIndex:int;
        private var channelWrapper:SoundChannelWrapper;
        private var bgvChannelWrapper:SoundChannelWrapper;
        private var bitmapContainer:BitmapContainer;
        private var currentOrder:BGVOrder;
        private var bgvs:Vector.<SoundFile>;
        private var bgvsByName:Dictionary;

        private var playList:Vector.<String> = new Vector.<String>();

        public function BGVPlayer(targetChannelIndex:int) {
            this.targetChannelIndex = targetChannelIndex;
        }

        public function execute():void {
        }

        public function setScenario(scenario:Scenario):void {
            if (scenario.BGVOrders.length == 0) {
                return;
            }

            for each (var o:BGVOrder in scenario.BGVOrders) {
                if (targetChannelIndex == o.CharacterChannel) {
                    currentOrder = o;
                    break;
                }
            }

            if (!channelWrapper.hasEventListener(Event.SOUND_COMPLETE)) {
                channelWrapper.addEventListener(Event.SOUND_COMPLETE, startBGV);
                channelWrapper.addEventListener(SoundChannelWrapper.SOUND_CHANNEL_REPLACED, stopBGV);
            }
        }

        /**
         * コンストラクタで入力したインデックスに従って、VoiceChannelWrapper[index], BitmapContainer[index + 1] をフィールドにセットします。
         * @param ui
         */
        public function setUI(ui:UIContainer):void {
            channelWrapper = ui.getVoiceChannelWrapperFromIndex(targetChannelIndex);
            bgvChannelWrapper = ui.getBGVChannelWrapperFromIndex(targetChannelIndex);

            // インデックス 0 は 背景担当。最低 1 から。
            bitmapContainer = ui.getBitmapContainerFromIndex(targetChannelIndex + 1);
        }

        public function setResource(res:Resource):void {
            bgvs = res.BGVs;
            bgvsByName = res.BGVsByName;
        }

        private function randomPlay(e:Event):void {
            if (currentOrder == null || currentOrder.Names.length == 0) {
                bgvChannelWrapper.removeEventListener(Event.SOUND_COMPLETE, randomPlay);
                bgvChannelWrapper.stop();
            }

            if (playList.length == 0) {

                // メソッド実行ごとに playList の中身を削る。
                // 実行時に要素がなかった場合は、currentOrder から取得、ランダムに並び替える。

                playList = currentOrder.Names.concat().sort(function():int {
                    return int(Math.random() * 3) - 1
                });
            }

            var soundFile:SoundFile = bgvsByName[playList.shift()];
            bgvChannelWrapper.setSoundChannel(soundFile.getSound().play());
        }

        private function startBGV(e:Event):void {
            channelWrapper.removeEventListener(Event.SOUND_COMPLETE, startBGV);
            bgvChannelWrapper.addEventListener(Event.SOUND_COMPLETE, randomPlay);
        }

        private function stopBGV(e:Event):void {
            bgvChannelWrapper.stop();
        }
    }
}
