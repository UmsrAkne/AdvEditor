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
    }
}
