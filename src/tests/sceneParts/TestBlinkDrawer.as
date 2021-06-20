package tests.sceneParts {

    import classes.sceneParts.BlinkDrawer;
    import classes.uis.BitmapContainer;
    import classes.sceneContents.Scenario;
    import classes.sceneContents.ImageOrder;
    import tests.Assert;
    import classes.sceneContents.Resource;

    public class TestBlinkDrawer {
        public function TestBlinkDrawer() {
            testExecute();
        }

        private function testExecute():void {
            var bmpContainer:BitmapContainer = new BitmapContainer(0);
            var res:Resource = new Resource();
            var blinkDrawer:BlinkDrawer = new BlinkDrawer(bmpContainer);
            blinkDrawer.setResource(res);

            var scenario1:Scenario = new Scenario();
            scenario1.ImagerOrders.push(new ImageOrder());
            scenario1.ImagerOrders[0].names.push("AtestImage1.png", "BtestImage1.png");
            scenario1.ImagerOrders[0].targetLayerIndex = 0;

            blinkDrawer.setScenario(scenario1);
            Assert.areEqual(blinkDrawer.CurrentEyeImageName, "BtestImage1.png");
        }
    }
}
