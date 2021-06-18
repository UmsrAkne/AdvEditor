package tests.sceneParts {

    import classes.sceneParts.BlinkDrawer;
    import classes.uis.BitmapContainer;

    public class TestBlinkDrawer {
        public function TestBlinkDrawer() {
            testExecute();
        }

        private function testExecute():void {
            var bmpContainer:BitmapContainer = new BitmapContainer(0);
            var blinkDrawer:BlinkDrawer = new BlinkDrawer(bmpContainer);
        }
    }
}
