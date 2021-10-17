package tests.animes {

    import classes.animes.Shake;
    import tests.Assert;
    import flash.display.Sprite;

    public class TestShake {
        public function TestShake() {
            testExecute();
            testLoopExecute();
            testDelayExecute();
        }

        private function testExecute():void {
            var shake:Shake = new Shake();
            var sprite:Sprite = new Sprite();
            shake.Target = sprite;
            shake.strength = 10;
            shake.duration = 12;

            shake.execute();
            Assert.areNotEqual(sprite.x, 0);
            Assert.areNotEqual(sprite.y, 0);

            for (var i:int = 0; i < 12; i++) {
                shake.execute();
            }

            Assert.areEqual(sprite.x, 0);
            Assert.areEqual(sprite.y, 0);
        }

        private function testLoopExecute():void {

            var shake:Shake = new Shake();
            var sprite:Sprite = new Sprite();
            shake.Target = sprite;
            shake.strength = 10;
            shake.duration = 12;
            shake.loopCount = 3;

            shake.execute();
            Assert.areNotEqual(sprite.x, 0);
            Assert.areNotEqual(sprite.y, 0);

            for (var i:int = 0; i < 11; i++) {
                shake.execute();
            }

            // 1 + 11 = 12 回実行したタイミング。ループの境目地点。
            // sprite のポジションは 0 に戻っているはず。
            Assert.areEqual(sprite.x, 0);
            Assert.areEqual(sprite.y, 0);
            Assert.isTrue(shake.Valid);

            shake.execute();

            Assert.areNotEqual(sprite.x, 0);
            Assert.areNotEqual(sprite.y, 0);

            for (i = 0; i < 11; i++) {
                shake.execute();
            }

            Assert.areEqual(sprite.x, 0);
            Assert.areEqual(sprite.y, 0);

            for (i = 0; i < 36; i++) {
                shake.execute();
            }

            Assert.areEqual(sprite.x, 0);
            Assert.areEqual(sprite.y, 0);
            Assert.isFalse(shake.Valid);
        }

        private function testDelayExecute():void {
            var shake:Shake = new Shake();
            var sprite:Sprite = new Sprite();
            shake.Target = sprite;
            shake.strength = 10;
            shake.duration = 12;
            shake.delay = 10;

            for (var i:int = 0; i < 10; i++) {
                shake.execute();
            }

            // まだ delay の範囲内なので動かない。
            Assert.areEqual(sprite.x, 0);
            Assert.areEqual(sprite.y, 0);

            // この実行で x or y が動く。
            shake.execute();
            shake.execute();
            Assert.areNotEqual(sprite.x, sprite.y);

            for (i = 0; i < 12; i++) {
                shake.execute();
            }

            // アニメーション終了時
            Assert.areEqual(sprite.x, 0);
            Assert.areEqual(sprite.y, 0);
        }
    }
}
