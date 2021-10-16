package tests.animes {

    import classes.animes.MultiAlphaChanger;
    import flash.display.Sprite;
    import tests.Assert;

    public class TestMultiAlphaChanger {
        public function TestMultiAlphaChanger() {
            targetTest();
            delayExecuteTest();
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

        private function delayExecuteTest():void {
            var multiAlphaChanger:MultiAlphaChanger = new MultiAlphaChanger();
            var parentSprite:Sprite = new Sprite();
            var backSprite:Sprite = new Sprite();
            var backSpriteB:Sprite = new Sprite();
            var frontSprite:Sprite = new Sprite();
            frontSprite.alpha = 0;

            parentSprite.addChild(backSpriteB);
            parentSprite.addChild(backSprite);
            parentSprite.addChild(frontSprite);

            // frontSprite から親を辿って parentSprite を参照するため frontSprite を代入
            multiAlphaChanger.Target = frontSprite;

            multiAlphaChanger.frontDelay = 5;
            multiAlphaChanger.backsDelay = 10;

            for (var i:int = 0; i < 5; i++) {
                multiAlphaChanger.execute();
            }

            // delay の範囲内なのでまだ値は変化しない
            Assert.areEqual(backSprite.alpha, 1);
            Assert.areEqual(backSpriteB.alpha, 1);
            Assert.areEqual(frontSprite.alpha, 0);

            for (i = 0; i < 5; i++) {
                multiAlphaChanger.execute();
            }

            // front の値の変動が起こる
            Assert.areEqual(backSprite.alpha, 1);
            Assert.areEqual(backSpriteB.alpha, 1);
            Assert.isTrue(frontSprite.alpha > 0.4);

            for (i = 0; i < 5; i++) {
                multiAlphaChanger.execute();
            }

            // backs の値が変動
            Assert.isTrue(backSprite.alpha < 0.6);
            Assert.isTrue(backSpriteB.alpha < 0.6);
            Assert.isTrue(frontSprite.alpha > 0.9);

            for (i = 0; i < 10; i++) {
                multiAlphaChanger.execute();
            }

            Assert.areEqual(backSprite.alpha, 0);
            Assert.areEqual(backSpriteB.alpha, 0);
            Assert.areEqual(frontSprite.alpha, 1);

            Assert.isFalse(multiAlphaChanger.Valid);
        }
    }
}
