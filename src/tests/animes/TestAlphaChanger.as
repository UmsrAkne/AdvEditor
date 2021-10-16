package tests.animes {

    import classes.animes.AlphaChanger;
    import flash.display.Sprite;
    import tests.Assert;

    public class TestAlphaChanger {
        public function TestAlphaChanger() {
            testExecute();
            testDelayExecute();
        }

        private function testExecute():void {
            // alpha を 0 から増やしていき、最終的に 1 になるか確認する。
            var alphaIncreaser:AlphaChanger = new AlphaChanger();
            var sprite:Sprite = new Sprite();
            sprite.alpha = 0;
            alphaIncreaser.Target = sprite;

            for (var i:int = 0; i < 12; i++) {
                alphaIncreaser.execute();
            }

            Assert.areEqual(sprite.alpha, 1);
            Assert.isFalse(alphaIncreaser.Valid);

            // alpha を完全に変化させるためには Duration が足りないパターン。
            // 最終的に alpha が 1 になっている確認する。
            var alphaIncreaser2:AlphaChanger = new AlphaChanger();
            sprite.alpha = 0;
            alphaIncreaser2.duration = 6;
            alphaIncreaser2.Target = sprite;

            for (i = 0; i < 10; i++) {
                alphaIncreaser2.execute();
            }

            Assert.areEqual(sprite.alpha, 1);
            Assert.isFalse(alphaIncreaser2.Valid);
        }

        private function testDelayExecute():void {
            var alphaIncreaser:AlphaChanger = new AlphaChanger();
            alphaIncreaser.delay = 12;
            alphaIncreaser.amount = 0.1;

            var sprite:Sprite = new Sprite();
            sprite.alpha = 0;
            alphaIncreaser.Target = sprite;

            for (var i:int = 0; i < 12; i++) {
                alphaIncreaser.execute();
            }

            // 12フレーム経過時点では alpha == 0 のまま。
            Assert.areEqual(sprite.alpha, 0);
            Assert.isTrue(alphaIncreaser.Valid);

            alphaIncreaser.execute();

            // この段階で 0 から値が増加する。
            Assert.isTrue(sprite.alpha > 0);

            for (i = 0; i < 12; i++) {
                alphaIncreaser.execute();
            }

            Assert.areEqual(sprite.alpha, 1);
        }
    }
}
