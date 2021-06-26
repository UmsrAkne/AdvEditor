package classes.sceneParts {

    import classes.animes.IAnimation;
    import classes.sceneContents.Scenario;
    import classes.uis.UIContainer;
    import classes.sceneContents.Resource;
    import classes.uis.BitmapContainer;
    import classes.animes.AlphaChanger;
    import classes.sceneContents.StopOrder;

    public class Animator implements IScenarioSceneParts {

        private var animations:Vector.<IAnimation> = new Vector.<IAnimation>();
        private var bitmapContainer:BitmapContainer;
        private var stopAnimationNames:Vector.<String> = new Vector.<String>();

        public function Animator(targetBitmapContainer:BitmapContainer) {
            bitmapContainer = targetBitmapContainer;
            bitmapContainer.addEventListener(BitmapContainer.BITMAP_ADDED, changeTarget);
            bitmapContainer.addEventListener(BitmapContainer.BITMAP_ADDED, addAlphaChanger);
        }

        /**
         * addAnimation() によって入力されたアニメーションを全て実行します。
         */
        public function executeAnimations():void {
            if (stopAnimationNames.length != 0) {
                for each (var a:IAnimation in animations) {
                    for each (var animationName:String in stopAnimationNames) {
                        if (a.AnimationName == animationName) {
                            a.stop();
                        }
                    }
                }

                stopAnimationNames = new Vector.<String>();
            }

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
            for each (var order:StopOrder in scenario.StopOrders) {
                if (order.Index != bitmapContainer.LayerIndex) {
                    continue;
                }

                var allowedAnimationNames:Vector.<String> = order.AllowedTargetAnimationNames;

                for each (var aName:String in allowedAnimationNames) {
                    if (order.Target == aName) {
                        stopAnimationNames.push(aName);
                    }
                }
            }

            for each (var anime:IAnimation in scenario.Animations) {
                if (anime.TargetLayerIndex == bitmapContainer.LayerIndex) {
                    addAnimation(anime);
                }
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

        /**
         * BitmapContainer に Bitmap が追加された際、そのオブジェクトに透明度変更のアニメーションをさせるためのメソッド。
         * このメソッドは、各シーンパーツの setScenario() 完了後の ImageDrawer.execute() のタイミングで呼び出しがかかる。
         * そのため、別途 Scenario.Animations にユーザー指定の AlphaChanger が入っていて、this.animations に AlphaChanger が既に入力されていることがあり得るが、
         * その場合、このメソッドによるアニメーションの追加は行われない。
         * @param event
         */
        private function addAlphaChanger(event:Object):void {
            if (animations.some(function(item:IAnimation, idx:int, v:Vector.<IAnimation>):Boolean {
                return item is AlphaChanger;
            })) {
                // animations に AlphaChanger が入っているか確認し、入っていれば処理を抜ける。
                return;
            }

            addAnimation(new AlphaChanger());
        }
    }
}
