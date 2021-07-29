package tests.animes {

    import classes.animes.LoopSlide;
    import flash.display.Bitmap;
    import flash.display.BitmapData;

    public class TestLoopSlide {
        public function TestLoopSlide() {
            test();
        }

        private function test():void {
            var loopSlide:LoopSlide = new LoopSlide();
            var bitmap:Bitmap = new Bitmap(new BitmapData(10, 10, false, 0x0));
            loopSlide.Target = bitmap;
        }
    }
}
