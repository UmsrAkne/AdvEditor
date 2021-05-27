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
            bitmapContainer.addEventListener(BitmapContainer.BITMAP_ADDED, changeTarget);
        }

        /**
         * addAnimation() によって入力されたアニメーションを全て実行します。
         */
        public function executeAnimations():void {
            if (animations.length == 0) {
                return;
            }

            for (var i:int = 0; i < animations.length; i++) {
                if (!animations[i].Valid) {
                    animations[i].stop();
                    animations.slice(i, 1);
                    i--;
                }
            }

            for each (var anime:IAnimation in animations) {
                anime.execute();
            }

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
            for (var i:int = 0; i < animations.length; i++) {
                if (animations[i].AnimationName == anime.AnimationName) {
                    animations[i] = anime;
                    return;
                }
            }

            animations.push(anime);
        }

        private function changeTarget(event:Object):void {
            for each (var anime:IAnimation in animations) {
                anime.Target = bitmapContainer.Front;
            }
        }
    }
}
