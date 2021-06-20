package tests.sceneContents {

    import classes.sceneContents.BlinkOrder;
    import tests.Assert;

    public class TestBlinkOrder {
        public function TestBlinkOrder() {
            test();
        }

        private function test():void {
            var blinkOrder:BlinkOrder = new BlinkOrder();
            blinkOrder.CloseImageName = "close";
            blinkOrder.OpenImageNames.push("open1", "open2", "open3");
            var names:Vector.<String> = blinkOrder.buildOrder();

            Assert.areEqual(names[0], "open3");
            Assert.areEqual(names[1], "open2");
            Assert.areEqual(names[2], "open1");
            Assert.areEqual(names[3], "close");
            Assert.areEqual(names[4], "open1");
            Assert.areEqual(names[5], "open2");
            Assert.areEqual(names[6], "open3");
        }
    }
}
