package tests.sceneParts {

    import classes.sceneContents.Scenario;
    import classes.sceneParts.LipDrawer;
    import classes.uis.BitmapContainer;
    import classes.uis.UIContainer;
    import classes.sceneContents.Resource;
    import classes.sceneContents.ImageOrder;
    import classes.sceneContents.LipOrder;
    import flash.display.BitmapData;
    import flash.display.Bitmap;

    public class TestLipDrawer {
        public function TestLipDrawer() {
            test();
        }

        private function test():void {
            var scenario:Scenario = new Scenario();
            var bmpContainer:BitmapContainer = new BitmapContainer(1);
            bmpContainer.add(new Bitmap(new BitmapData(5, 5)));
            var ui:UIContainer = new UIContainer();
            var res:Resource = new Resource();
            var drawer:LipDrawer = new LipDrawer(bmpContainer);
            drawer.setUI(ui)
            drawer.setResource(res);

            var order:ImageOrder = new ImageOrder();
            order.names.push("a", "b", "c");
            order.targetLayerIndex = 1;

            var lipOrder:LipOrder = new LipOrder();
            lipOrder.BaseImageName = "c";
            lipOrder.CloseImageName = "closeImage";
            lipOrder.OpenImageNames.push("openImage1", "openImage2");

            res.BitmapDatasByName["c"] = new BitmapData(5, 5);
            res.BitmapDatasByName["closeImage"] = new BitmapData(5, 5);
            res.BitmapDatasByName["openImage1"] = new BitmapData(5, 5);
            res.BitmapDatasByName["openImage2"] = new BitmapData(5, 5);

            res.LipOrdersByName["c"] = lipOrder;

            scenario.ImagerOrders.push(order);

            drawer.setScenario(scenario);
            drawer.drawLip();

            for (var i:int = 0; i < 200; i++) {
                drawer.drawLip();
            }
        }
    }
}
