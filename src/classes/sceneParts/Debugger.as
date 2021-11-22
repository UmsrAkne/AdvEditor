package classes.sceneParts {

    import classes.sceneContents.Scenario;
    import classes.uis.UIContainer;
    import classes.sceneContents.Resource;
    import flash.text.TextField;
    import flash.utils.getTimer;

    public class Debugger implements IEnterFrameExecuter, IScenarioSceneParts {

        private var isEnabled:Boolean = true;
        private var textWindow:TextField;
        private var drawCount:int;
        private var oldTime:int;

        public function Debugger() {
        }

        public function executeOnEnterFrame():void {
            if (!isEnabled) {
                return;
            }

            drawCount++;
            if (getTimer() - oldTime >= 1000) {
                var fps:Number = drawCount * 1000 / (getTimer() - oldTime);
                fps = Math.floor(fps * 10) / 10;

                textWindow.text = String(fps);
                oldTime = getTimer();
                drawCount = 0;
            }
        }

        public function execute():void {
        }

        public function setScenario(scenario:Scenario):void {
        }

        public function setUI(ui:UIContainer):void {
            textWindow = ui.DebugTextWindow;
        }

        public function setResource(res:Resource):void {
        }

        public function dispose():void {
        }

        public function set IsEnabled(value:Boolean):void {
            isEnabled = value;
            textWindow.visible = value;
        }

        public function get IsEnabled():Boolean {
            return isEnabled;
        }
    }
}
