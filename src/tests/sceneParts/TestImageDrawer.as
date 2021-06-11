package tests.sceneParts {

    import classes.sceneParts.ImageDrawer;
    import classes.uis.BitmapContainer;
    import classes.sceneContents.Resource;
    import classes.sceneContents.Scenario;
    import classes.sceneContents.ImageOrder;
    import tests.Assert;
    import flash.display.BitmapData;
    import flash.events.Event;
    import flash.display.Bitmap;

    public class TestImageDrawer {
        public function TestImageDrawer() {
            testExecute();
            連続実行のテスト();
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

        public function 連続実行のテスト():void {
            var bitmapContainer:BitmapContainer = new BitmapContainer(0);
            var imageDrawer:ImageDrawer = new ImageDrawer(bitmapContainer);

            var resource:Resource = new Resource();
            resource.BitmapDatas.push(new BitmapData(10, 10, true, 0xFFFFFFFF));
            resource.BitmapDatas.push(new BitmapData(10, 10, true, 0xFFFFFFFF));
            resource.BitmapDatas.push(new BitmapData(10, 10, true, 0xFF000000));
            imageDrawer.setResource(resource);

            var scenarios:Vector.<Scenario> = new Vector.<Scenario>();
            scenarios.push(new Scenario(), new Scenario(), new Scenario());

            var imageOrder1:ImageOrder = new ImageOrder();
            imageOrder1.targetLayerIndex = 0;
            imageOrder1.indexes.push(1, 0, 0);
            imageOrder1.x = 100;
            scenarios[0].ImagerOrders.push(imageOrder1)

            var drawImageOrder:ImageOrder = new ImageOrder();
            drawImageOrder.targetLayerIndex = 0;
            drawImageOrder.drawingDepth = 0.1;
            drawImageOrder.indexes.push(2, 0, 0);
            scenarios[1].DrawingOrder.push(drawImageOrder);

            var nextImageOrder:ImageOrder = new ImageOrder();
            nextImageOrder.targetLayerIndex = 0;
            nextImageOrder.indexes.push(1, 0, 0);
            nextImageOrder.statusInherit = true;
            scenarios[2].ImagerOrders.push(nextImageOrder);

            imageDrawer.setScenario(scenarios[0]);
            imageDrawer.execute()

            var bmp1:Bitmap = bitmapContainer.Front;
            Assert.areEqual(bmp1.x, 100);

            imageDrawer.setScenario(scenarios[1]);
            imageDrawer.execute();

            // 何回か Event.ENTER_FRAME を送出。描画中で次の Bitmap を追加する。
            imageDrawer.dispatchEvent(new Event(Event.ENTER_FRAME));
            imageDrawer.dispatchEvent(new Event(Event.ENTER_FRAME));
            imageDrawer.dispatchEvent(new Event(Event.ENTER_FRAME));

            // 現状では、白よりも暗い色になっているはず。
            Assert.isTrue(bitmapContainer.Front.bitmapData.getPixel32(0, 0) < 0xFFFFFFFF);

            imageDrawer.setScenario(scenarios[2]);
            imageDrawer.execute();

            var bmp3:Bitmap = bitmapContainer.Front;
            Assert.areEqual(bmp3.x, 100);

            for (var i:int; i < 20; i++) {
                imageDrawer.dispatchEvent(new Event(Event.ENTER_FRAME));
            }

            // Bitmap を1枚追加した状態でフロントだったオブジェクト。最初は白で追加されているが、最終的に黒に書き換わる。
            Assert.areEqual(bmp1.bitmapData.getPixel32(0, 0), 0xFF000000);
            Assert.areEqual(bmp3.bitmapData.getPixel32(0, 0), 0xFFFFFFFF);
        }
    }
}
