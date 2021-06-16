package tests.contentsLoaders.xmlElements {

    import classes.contentsLoaders.xmlElements.ImageElementConverter;
    import flash.filesystem.File;
    import classes.sceneContents.Scenario;
    import tests.Assert;

    public class TestImageElementConverter {
        public function TestImageElementConverter() {
            testConvert();
        }

        private function testConvert():void {
            var imageElementConverter:ImageElementConverter = new ImageElementConverter(new File(File.applicationDirectory.nativePath));
            var fileList:Vector.<File> = new Vector.<File>();

            var testXML1:XML = new XML("<scenario>  <image a=\"Aimg01\" c=\"Cimg01\" x=\"-100\" scale=\"2.0\" rotation=\"20\" statusInherit=\"true\" target=\"front\"/> <image a=\"Aimg02\" target=\"main\" /> </scenario>");
            var scenario1:Scenario = new Scenario();

            imageElementConverter.convert(testXML1, scenario1);
            Assert.areEqual(scenario1.ImagerOrders[0].names[0], "Aimg01");
            Assert.areEqual(scenario1.ImagerOrders[0].names[1], "");

            Assert.areEqual(scenario1.ImagerOrders[0].x, -100);
            Assert.areEqual(scenario1.ImagerOrders[0].y, 0);
            Assert.areEqual(scenario1.ImagerOrders[0].scale, 2.0);
            Assert.areEqual(scenario1.ImagerOrders[0].rotation, 20);
            Assert.isTrue(scenario1.ImagerOrders[0].statusInherit);
            Assert.areEqual(scenario1.ImagerOrders[0].targetLayerIndex, 3);

            Assert.areEqual(scenario1.ImagerOrders.length, 2);

            Assert.isFalse(scenario1.ImagerOrders[1].statusInherit);
            Assert.areEqual(scenario1.ImagerOrders[1].rotation, 0);
        }
    }
}
