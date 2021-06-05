package tests.sceneParts {

    import classes.sceneParts.ImageDrawer;
    import classes.uis.BitmapContainer;
    import classes.sceneContents.Resource;
    import classes.sceneContents.Scenario;
    import classes.sceneContents.ImageOrder;
    import tests.Assert;
    import flash.display.BitmapData;

    public class TestImageDrawer {
        public function TestImageDrawer() {
            testExecute();
        }

        public function testExecute():void {
            var bitmapContainer:BitmapContainer = new BitmapContainer(0)
            var imageDrawer:ImageDrawer = new ImageDrawer(bitmapContainer);

            var resource:Resource = new Resource();
            resource.BitmapDatas.push(new BitmapData(10, 10, true, 0xFFFFFFFF));
            resource.BitmapDatas.push(new BitmapData(10, 10, true, 0xFFFFFFFF));
            resource.BitmapDatas.push(new BitmapData(10, 10, true, 0xFFFFFFFF));
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
