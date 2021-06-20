package tests.sceneContents {

    import classes.sceneContents.LipOrder;
    import tests.Assert;

    public class TestLipOrder {
        public function TestLipOrder() {
            testGetOrder();
        }

        private function testGetOrder():void {
            var order:LipOrder = new LipOrder();
            order.CloseImageName = "close";
            order.OpenImageNames.push("open1", "open2", "open3");
            var names:Vector.<String> = order.getOrder();

            Assert.areEqual(names.length, 4);
            Assert.areEqual(names[0], "close");
            Assert.areEqual(names[1], "open1");
            Assert.areEqual(names[2], "open2");
            Assert.areEqual(names[3], "open3");

            // getOrder() は初回呼び出し以降は、初回で生成したベクターをそのまま返す。
            Assert.areEqual(names, order.getOrder());

            // buildOrder を呼び出すと、新しいベクターを生成する。
            order.buildOrder();
            Assert.areNotEqual(names, order.getOrder());
        }
    }
}
