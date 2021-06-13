package tests.animes {

    import classes.animes.Slide;
    import flash.display.Sprite;

    public class TestSlide {
        public function TestSlide() {
            testExecute();
        }

        private function testExecute():void {
            var slide:Slide = new Slide();
            slide.degree = 90;
            slide.speed = 2;
            slide.distance = 300;

            var sp:Sprite = new Sprite();
            slide.Target = sp;

            slide.execute();
        }
    }
}
