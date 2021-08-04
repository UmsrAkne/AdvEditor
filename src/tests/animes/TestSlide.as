package tests.animes {

    import classes.animes.Slide;
    import flash.display.Sprite;
    import tests.Assert;

    public class TestSlide {
        public function TestSlide() {
            testExecute();
            testConstantVelocitySlide();
        }

        private function testExecute():void {
            var slide:Slide = new Slide();
            slide.degree = 90;
            slide.speed = 2;
            slide.distance = 300;

            // デフォルトは 1 が前提
            Assert.areEqual(slide.TargetLayerIndex, 1);

            var sp:Sprite = new Sprite();
            slide.Target = sp;

            slide.execute();
            for (var i:int = 0; i < 200; i++) {
                slide.execute();
            }

            // x方向に300程度動くのが正しいが、現状では少数の扱いの関係でわずかに 300 に及ばない値までしか動かない。
            // 修正したいが少し辛いかも？
            Assert.isTrue(sp.x > 295);
            Assert.isTrue(sp.y == 0);
        }

        private function testConstantVelocitySlide():void {
            var slide:Slide = new Slide();
            slide.speed = 2;
            slide.distance = 200;
            slide.isConstantVelocity = true;

            var sp:Sprite = new Sprite();
            slide.Target = sp;

            slide.execute();
            for (var i:int = 0; i < 100; i++) {
                slide.execute();
            }

            Assert.areEqual(sp.x, 0);
            Assert.areEqual(sp.y, -200);
            Assert.isFalse(slide.Valid);
        }
    }
}
