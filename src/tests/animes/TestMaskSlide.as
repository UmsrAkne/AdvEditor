package tests.animes {

    import classes.animes.MaskSlide;
    import flash.display.Sprite;
    import flash.display.Bitmap;
    import flash.display.BitmapData;
    import tests.Assert;
    import classes.uis.BitmapContainer;

    public class TestMaskSlide {
        public function TestMaskSlide() {
            test();
        }

        private function test():void {
            var maskSlide:MaskSlide = new MaskSlide();

            Assert.areEqual(maskSlide.TargetLayerIndex, 1);

            var bitmapContainer:BitmapContainer = new BitmapContainer(0);
            var bmp:Bitmap = new Bitmap(new BitmapData(10, 10));
            bitmapContainer.addChild(bmp);
            var m:Bitmap = new Bitmap(new BitmapData(10, 10, false));
            bitmapContainer.mask = m;
            maskSlide.Target = bmp;

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
