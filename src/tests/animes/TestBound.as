package tests.animes {

    import classes.animes.Bound;
    import flash.display.Sprite;
    import tests.Assert;

    public class TestBound {
        public function TestBound() {
            test();
            testLoopExecute();
        }

        private function test():void {
            var bound:Bound = new Bound();
            var sp:Sprite = new Sprite();
            bound.Target = sp;
            bound.degree = 45;
            bound.strength = 5;
            bound.duration = 14;

            // execute を一度実行した状態では、座標は原点から離れている
            bound.execute();
            Assert.areNotEqual(sp.x, 0);
            Assert.areNotEqual(sp.y, 0);

            for (var i:int = 0; i < 18; i++) {
                bound.execute();
            }

            // duration 以上の回数実行した後は元の位置（原点）に戻る
            Assert.areEqual(sp.x, 0);
            Assert.areEqual(sp.y, 0);
        }

        private function testLoopExecute():void {
            var bound:Bound = new Bound();
            var sp:Sprite = new Sprite();
            bound.Target = sp;
            bound.degree = 45;
            bound.strength = 5;
            bound.duration = 14;
            bound.interval = 6;
            bound.loopCount = 3;

            bound.execute();
            Assert.areNotEqual(sp.x, 0);
            Assert.areNotEqual(sp.y, 0);

            for (var i:int = 0; i < 13; i++) {
                bound.execute();
            }

            Assert.areEqual(sp.x, 0);
            Assert.areEqual(sp.y, 0);

            for (i = 0; i < 6; i++) {
                //インターバル区間
                bound.execute();
            }

            bound.execute();

            Assert.areNotEqual(sp.x, 0);
            Assert.areNotEqual(sp.y, 0);

            for (i = 0; i < 13; i++) {
                // アニメーションの途中。スプライトの座標は常に原点から離れた位置にある。
                Assert.isTrue(Math.abs(sp.x) > 0);
                Assert.isTrue(Math.abs(sp.y) > 0);
                bound.execute();
            }

            for (i = 0; i < 40; i++) {
                // duration に設定した値以上の回数実行する。
                bound.execute();
            }

            // スプライトは元の位置に戻っており、アニメーションは無効になっている。
            Assert.areEqual(sp.x, 0);
            Assert.areEqual(sp.y, 0);
            Assert.isFalse(bound.Valid);
        }
    }
}
