package tests.animes {

    import classes.animes.Shake;
    import tests.Assert;
    import flash.display.Sprite;

    public class TestShake {
        public function TestShake() {
            testExecute();
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
    }
}
