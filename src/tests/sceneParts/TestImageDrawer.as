package tests.sceneParts {

    import classes.sceneParts.ImageDrawer;
    import classes.uis.BitmapContainer;

    public class TestImageDrawer {
        public function TestImageDrawer() {
            testExecute();
        }

        public function testExecute():void {
            var imageDrawer:ImageDrawer = new ImageDrawer(new BitmapContainer(0));
        }
    }
}
