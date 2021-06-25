package tests.contentsLoaders.xmlElements {

    import classes.contentsLoaders.xmlElements.BackVoiceElementConverter;
    import flash.filesystem.File;
    import tests.Assert;
    import classes.sceneContents.Scenario;

    public class TestBackVoiceElementConverter {
        public function TestBackVoiceElementConverter() {
            test();
        }

        private function test():void {
            var bgVoiceElementConverter:BackVoiceElementConverter = new BackVoiceElementConverter(File.applicationDirectory);
            var xml:XML = new XML("<scenario><backVoice characterChannel=\"2\" names=\"v1, v2 ,v3 ,v4\" /><backVoice names=\"v5,v6\" /></scenario>")
            var scenario:Scenario = new Scenario();

            bgVoiceElementConverter.convert(xml, scenario);

            Assert.areEqual(scenario.BGVOrders.length, 2);
            Assert.areEqual(scenario.BGVOrders[0].CharacterChannel, 2);
            Assert.areEqual(scenario.BGVOrders[0].Names[0], "v1");
            Assert.areEqual(scenario.BGVOrders[0].Names[1], "v2");
            Assert.areEqual(scenario.BGVOrders[0].Names[2], "v3");
            Assert.areEqual(scenario.BGVOrders[0].Names[3], "v4");

            Assert.areEqual(scenario.BGVOrders[1].Names[0], "v5");
            Assert.areEqual(scenario.BGVOrders[1].Names[1], "v6");
        }
    }
}
