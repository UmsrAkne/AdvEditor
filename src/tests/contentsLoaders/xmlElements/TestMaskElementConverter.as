package tests.contentsLoaders.xmlElements {

    import classes.contentsLoaders.xmlElements.MaskElementConverter;
    import classes.sceneContents.Scenario;
    import tests.Assert;

    public class TestMaskElementConverter {
        public function TestMaskElementConverter() {
            testConvert();
        }

        private function testConvert():void {
            var maskElementConverter:MaskElementConverter = new MaskElementConverter();
            var xml:XML = new XML("<scenario><mask a=\"150,0\" b=\"100,200\" c=\"0, 200\" /><mask a=\"100,0\" b=\"100,200\" c=\"0, 200\" /></scenario>");
            var scenario:Scenario = new Scenario();
            maskElementConverter.convert(xml, scenario);

            Assert.areEqual(scenario.Masks.length, 2);
            Assert.areEqual(scenario.Masks[0].shape.width, 150);
            Assert.areEqual(scenario.Masks[0].shape.height, 200);

            Assert.areEqual(scenario.Masks[1].shape.width, 100);
            Assert.areEqual(scenario.Masks[1].shape.height, 200);
        }
    }
}
