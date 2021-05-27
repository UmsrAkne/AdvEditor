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

            var existInvalidAnimation:Boolean;

            for each (var anime:IAnimation in animations) {
                anime.execute();
                if (!anime.Valid) {
                    existInvalidAnimation = true;
                }
            }

            if (existInvalidAnimation) {
                var newVec:Vector.<IAnimation> = new Vector.<IAnimation>();
                for each (anime in animations) {
                    if (anime.Valid) {
                        newVec.push(anime);
                    }
                }

                animations = newVec;
            }
        }

        public function execute():void {
            // 実装なし
        }

        public function setScenario(scenario:Scenario):void {
            for each (var anime:IAnimation in scenario.Animations) {
                addAnimation(anime);
            }
        }

        public function setUI(ui:UIContainer):void {
        }

        public function setResource(res:Resource):void {
        }

        public function get AnimationCount():int {
            return animations.length;
        }

        private function addAnimation(anime:IAnimation):void {
            anime.Target = bitmapContainer.Front;
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
