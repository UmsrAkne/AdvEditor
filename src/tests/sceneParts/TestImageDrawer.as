package tests.sceneParts {

    import classes.sceneParts.ImageDrawer;
    import classes.uis.BitmapContainer;
    import classes.sceneContents.Resource;
    import classes.sceneContents.Scenario;
    import classes.sceneContents.ImageOrder;
    import tests.Assert;
    import flash.display.BitmapData;
    import flash.events.Event;

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
            resource.BitmapDatas.push(new BitmapData(10, 10, true, 0xFF000000));
            imageDrawer.setResource(resource);

            var scenario1:Scenario = new Scenario();

            var imageOrder1:ImageOrder = new ImageOrder();
            imageOrder1.targetLayerIndex = 0;
            imageOrder1.indexes.push(1, 0, 0);
            scenario1.ImagerOrders.push(imageOrder1)

            imageDrawer.setScenario(scenario1);
            imageDrawer.execute()

            Assert.isTrue(bitmapContainer.Front != null);

            var scenario2:Scenario = new Scenario();
            var drawingOrder:ImageOrder = new ImageOrder();
            drawingOrder.targetLayerIndex = 0;
            drawingOrder.drawingDepth = 0.1;
            drawingOrder.indexes.push(2, 0, 0);
            scenario2.DrawingOrder.push(drawingOrder);

            imageDrawer.setScenario(scenario2);
            imageDrawer.execute();

            imageDrawer.dispatchEvent(new Event(Event.ENTER_FRAME));

            // 一度 BitmapData を上塗りした状態なので、白と黒の中間の色になっているはずなので確認する。
            Assert.isTrue(bitmapContainer.Front.bitmapData.getPixel32(0, 0) > 0xFF000000);
            Assert.isTrue(bitmapContainer.Front.bitmapData.getPixel32(0, 0) < 0xFFFFFFFF);

            for (var i:int = 0; i < 30; i++) {
                imageDrawer.dispatchEvent(new Event(Event.ENTER_FRAME));
            }

            Assert.areEqual(bitmapContainer.Front.bitmapData.getPixel32(0, 0), 0xFF000000)
        }
    }
}
