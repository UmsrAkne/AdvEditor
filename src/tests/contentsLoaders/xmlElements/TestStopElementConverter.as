package tests.contentsLoaders.xmlElements {

    import classes.contentsLoaders.xmlElements.StopElementConverter;
    import classes.sceneContents.Scenario;
    import tests.Assert;

    public class TestStopElementConverter {
        public function TestStopElementConverter() {
            test();
        }

        private function test():void {
            var stopElementConverter:StopElementConverter = new StopElementConverter();
            var xml:XML = new XML("<scenario><stop target=\"voice\" index=\"2\" /><stop target=\"se\" index=\"3\" /></scenario>");
            var scenario:Scenario = new Scenario();
            stopElementConverter.convert(xml, scenario);

            Assert.areEqual(scenario.StopOrders.length, 2);

            Assert.areEqual(scenario.StopOrders[0].Target, "voice");
            Assert.areEqual(scenario.StopOrders[0].Index, 2);

            Assert.areEqual(scenario.StopOrders[1].Target, "se");
            Assert.areEqual(scenario.StopOrders[1].Index, 3);
        }
    }
}
