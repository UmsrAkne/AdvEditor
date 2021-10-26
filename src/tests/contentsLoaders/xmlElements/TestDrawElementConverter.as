package tests.contentsLoaders.xmlElements {

    import classes.contentsLoaders.xmlElements.DrawElementConverter;
    import classes.sceneContents.Scenario;
    import tests.Assert;

    public class TestDrawElementConverter {
        public function TestDrawElementConverter() {
            testConvert();
        }

        private function testConvert():void {
            var drawElementConverter:DrawElementConverter = new DrawElementConverter();
            var xml:XML = new XML("<scenario><draw a=\"imageA\" b=\"imageB\" c=\"imageC\" d=\"imageD\" depth=\"0.1\" delay=\"8\" /></scenario>");
            var scenario:Scenario = new Scenario();
            drawElementConverter.convert(xml, scenario);

            Assert.areEqual(scenario.DrawingOrder[0].names[0], "imageA");
            Assert.areEqual(scenario.DrawingOrder[0].names[1], "imageB");
            Assert.areEqual(scenario.DrawingOrder[0].names[2], "imageC");
            Assert.areEqual(scenario.DrawingOrder[0].names[3], "imageD");
            Assert.areEqual(scenario.DrawingOrder[0].drawingDepth, 0.1);
            Assert.areEqual(scenario.DrawingOrder[0].delay, 8);
        }
    }
}
