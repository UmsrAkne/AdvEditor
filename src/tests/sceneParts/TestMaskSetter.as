package tests.sceneParts {

    import classes.sceneParts.MaskSetter;
    import classes.uis.BitmapContainer;
    import classes.sceneContents.Scenario;
    import classes.sceneContents.MaskOrder;
    import flash.display.Shape;
    import flash.display.Graphics;
    import flash.display.Stage;
    import flash.display.BitmapData;
    import flash.display.Bitmap;
    import flash.display.DisplayObjectContainer;
    import tests.Assert;

    public class TestMaskSetter {

        public function TestMaskSetter() {
            testExecute();
        }

        private function testExecute():void {
            var bitmapContainer:BitmapContainer = new BitmapContainer(0);
            bitmapContainer.add(new Bitmap(new BitmapData(300, 300, false, 0x000000)));

            var maskSetter:MaskSetter = new MaskSetter(bitmapContainer);

            var scenario:Scenario = new Scenario();
            var maskOrder:MaskOrder = new MaskOrder();
            var shape:Shape = new Shape();
            var g:Graphics = shape.graphics;
            g.beginFill(0x000000, 1);
            g.drawCircle(0, 0, 50);
            maskOrder.shape = shape;
            maskOrder.TargetLayerIndex = 0;
            scenario.Masks.push(maskOrder);

            maskSetter.setScenario(scenario);
            maskSetter.execute();

            Assert.isTrue(bitmapContainer.mask != null);
            Assert.areEqual(bitmapContainer.mask, shape);
        }
    }
}
