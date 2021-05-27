package classes.sceneParts {

    import classes.animes.IAnimation;
    import classes.sceneContents.Scenario;
    import classes.uis.UIContainer;
    import classes.sceneContents.Resource;
    import classes.uis.BitmapContainer;

    public class Animator implements IScenarioSceneParts {

        private var animations:Vector.<IAnimation> = new Vector.<IAnimation>();
        private var bitmapContainer:BitmapContainer

        public function Animator(targetBitmapContainer:BitmapContainer) {
            bitmapContainer = targetBitmapContainer;
        }

        /**
         * addAnimation() によって入力されたアニメーションを全て実行します。
         */
        public function executeAnimations():void {
        }

        public function execute():void {
            // 実装なし
        }

        public function setScenario(scenario:Scenario):void {
            throw new Error("Method not implemented.");
        }

        public function setUI(ui:UIContainer):void {
            throw new Error("Method not implemented.");
        }

        public function setResource(res:Resource):void {
            throw new Error("Method not implemented.");
        }

        private function addAnimation(anime:IAnimation):void {
        }
    }
}
