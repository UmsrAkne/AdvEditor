package tests.sceneParts {

    import classes.sceneParts.Animator;
    import classes.sceneContents.Scenario;
    import classes.animes.Shake;
    import classes.uis.BitmapContainer;
    import flash.display.Bitmap;
    import flash.display.BitmapData;
    import tests.Assert;

    public class TestAnimator {
        public function TestAnimator() {
            testExecuteAnimations();
            testExecuteAnimationsWhenImageAddition();
        }

        private function testExecuteAnimations():void {
            var bitmapContainer:BitmapContainer = new BitmapContainer(1);
            var testBitmap:Bitmap = new Bitmap(new BitmapData(5, 5, false, 0x0));
            bitmapContainer.add(testBitmap);

            var animator:Animator = new Animator(bitmapContainer);

            var scenario1:Scenario = new Scenario();
            scenario1.Animations.push(new Shake());
            animator.setScenario(scenario1);

            animator.executeAnimations();
            Assert.areEqual(animator.AnimationCount, 1);

            var scenario2:Scenario = new Scenario();
            var shake:Shake = new Shake();
            shake.duration = 12;
            scenario2.Animations.push(shake);

            animator.setScenario(scenario2);

            // 同種のアニメーションを入れた場合は上書きされるので数は増えない。
            Assert.areEqual(animator.AnimationCount, 1);

            for (var i:int = 0; i < 14; i++) {
                animator.executeAnimations();
            }

            // 実行回数が duration を超えたのでアニメーションは削除されて空に。
            Assert.areEqual(animator.AnimationCount, 0);
        }

        private function testExecuteAnimationsWhenImageAddition():void {
            // bitmapContainer に bitmap を追加した際、animator が alphaChanger を正しく扱うかどうかをテストする。
            var bitmapContainer:BitmapContainer = new BitmapContainer(1);
            var animator:Animator = new Animator(bitmapContainer);

            var testBitmap:Bitmap = new Bitmap(new BitmapData(5, 5, false, 0x0));
            testBitmap.alpha = 0;
            bitmapContainer.add(testBitmap);

            // 自動で AlphaChanger が入力されているはず
            Assert.areEqual(animator.AnimationCount, 1);

            for (var i:int = 0; i < 24; i++) {
                animator.executeAnimations();
            }

            Assert.areEqual(animator.AnimationCount, 0);
            Assert.areEqual(testBitmap.alpha, 1);
        }
    }
}