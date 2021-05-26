package tests.sceneParts {

    import classes.sceneParts.ImageDrawer;
    import classes.uis.BitmapContainer;
    import classes.sceneContents.Resource;
    import flash.display.Loader;
    import flash.display.Bitmap;
    import classes.sceneContents.Scenario;
    import classes.sceneContents.ImageOrder;
    import tests.Assert;

    public class TestImageDrawer {
        public function TestImageDrawer() {
            testExecute();
        }

        public function testExecute():void {
            var bitmapContainer:BitmapContainer = new BitmapContainer(0)
            var imageDrawer:ImageDrawer = new ImageDrawer(bitmapContainer);

            var resource:Resource = new Resource();
            resource.imageLoaders.push(new Loader());
            resource.imageLoaders.push(new Loader());
            imageDrawer.setResource(resource);

            var scenario1:Scenario = new Scenario();

            var imageOrder1:ImageOrder = new ImageOrder();
            imageOrder1.targetLayerIndex = 0;
            imageOrder1.indexes.push(1, 0, 0);
            scenario1.ImagerOrders.push(imageOrder1)

            imageDrawer.setScenario(scenario1);
            imageDrawer.execute()

            Assert.isTrue(bitmapContainer.Front != null);
        }
    }
}
