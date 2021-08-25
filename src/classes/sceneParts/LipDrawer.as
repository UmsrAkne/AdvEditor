package classes.sceneParts {

    import classes.sceneContents.Scenario;
    import classes.uis.UIContainer;
    import classes.sceneContents.Resource;
    import classes.uis.BitmapContainer;
    import classes.sceneContents.LipOrder;
    import flash.utils.Dictionary;
    import flash.display.Sprite;
    import classes.uis.SoundChannelWrapper;

    public class LipDrawer implements IScenarioSceneParts {

        private var bitmapContainer:BitmapContainer;
        private var currentLipOrder:LipOrder;
        private var bitmapDatas:Dictionary
        private var lipOrders:Dictionary;
        private var _enterFrameEventDispatcher:Sprite = new Sprite();
        private var soundChannel:SoundChannelWrapper;

        public function LipDrawer(targetBitmapContainer:BitmapContainer) {
            this.bitmapContainer = targetBitmapContainer;
        }

        public function execute():void {
            throw new Error("Method not implemented.");
        }

        public function setScenario(scenario:Scenario):void {
            throw new Error("Method not implemented.");
        }

        public function setUI(ui:UIContainer):void {
            soundChannel = ui.getVoiceChannelWrapperFromIndex(bitmapContainer.LayerIndex - 1);
        }

        public function setResource(res:Resource):void {
            bitmapDatas = res.BitmapDatasByName;
            lipOrders = res.LipOrdersByName
        }

        public function dispose():void {
            throw new Error("Method not implemented.");
        }

        public function get enterFrameEventDispatcher():Sprite {
            return _enterFrameEventDispatcher;
        }
    }
}
