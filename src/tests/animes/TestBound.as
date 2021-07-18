package tests.animes {

    import classes.animes.Bound;
    import flash.display.Sprite;
    import tests.Assert;

    public class TestBound {
        public function TestBound() {
            test();
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
    }
}
