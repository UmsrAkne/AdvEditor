package classes.sceneParts {

    import classes.sceneContents.Scenario;
    import classes.sceneContents.Resource;
    import classes.uis.UIContainer;
    import classes.uis.SoundChannelWrapper;
    import classes.uis.BitmapContainer;
    import classes.sceneContents.SoundFile;
    import flash.utils.Dictionary;

    public class BGVPlayer implements IScenarioSceneParts {

        private var targetChannelIndex:int;
        private var channelWrapper:SoundChannelWrapper;
        private var bitmapContainer:BitmapContainer;
        private var bgvs:Vector.<SoundFile>;
        private var bgvsByName:Dictionary;

        public function BGVPlayer(targetChannelIndex:int) {
            this.targetChannelIndex = targetChannelIndex;
        }

        public function execute():void {
            throw new Error("Method not implemented.");
        }

        public function setScenario(scenario:Scenario):void {
            throw new Error("Method not implemented.");
        }

        /**
         * コンストラクタで入力したインデックスに従って、VoiceChannelWrapper[index], BitmapContainer[index + 1] をフィールドにセットします。
         * @param ui
         */
        public function setUI(ui:UIContainer):void {
            channelWrapper = ui.getVoiceChannelWrapperFromIndex(targetChannelIndex);

            // インデックス 0 は 背景担当。最低 1 から。
            bitmapContainer = ui.getBitmapContainerFromIndex(targetChannelIndex + 1);
        }

        public function setResource(res:Resource):void {
            bgvs = res.BGVs;
            bgvsByName = res.BGVsByName;
        }
    }
}
