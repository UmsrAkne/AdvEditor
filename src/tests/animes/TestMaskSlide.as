package tests.animes {

    import classes.animes.MaskSlide;
    import flash.display.Sprite;
    import flash.display.Bitmap;
    import flash.display.BitmapData;
    import tests.Assert;

    public class TestMaskSlide {
        public function TestMaskSlide() {
            test();
        }

        private function test():void {
            var maskSlide:MaskSlide = new MaskSlide();

            Assert.areEqual(maskSlide.TargetLayerIndex, 1);

            var baseSprite:Sprite = new Sprite();
            var m:Bitmap = new Bitmap(new BitmapData(10, 10, false));
            baseSprite.mask = m;
            maskSlide.Target = baseSprite;
            maskSlide.speed = 3;
            maskSlide.distance = 100;
            maskSlide.degree = 90;

            var i:int = 0;
            for (i = 0; i < 100; i++) {
                maskSlide.execute();
            }

            Assert.areEqual(Math.round(m.x), 100);
        }
    }
}
