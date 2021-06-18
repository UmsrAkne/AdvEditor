package tests.animes {

    import classes.animes.MultiAlphaChanger;
    import flash.display.Sprite;
    import tests.Assert;

    public class TestMultiAlphaChanger {
        public function TestMultiAlphaChanger() {
            targetTest();
        }

        private function targetTest():void {
            var multiAlphaChanger:MultiAlphaChanger = new MultiAlphaChanger();

            var parentSprite:Sprite = new Sprite();
            var backSprite:Sprite = new Sprite();

            var frontSprite:Sprite = new Sprite();
            frontSprite.alpha = 0;

            parentSprite.addChild(backSprite);
            parentSprite.addChild(frontSprite);

            multiAlphaChanger.Target = frontSprite;

            multiAlphaChanger.execute();

            Assert.isTrue(backSprite.alpha < 1);
            Assert.isTrue(frontSprite.alpha > 0);

            for (var i:int = 0; i < 20; i++) {
                multiAlphaChanger.execute();
            }

            Assert.isTrue(backSprite.alpha == 0);
            Assert.isTrue(frontSprite.alpha == 1);
            Assert.isFalse(multiAlphaChanger.Valid);
        }
    }
}
