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
            fileList.push(new File("/test/Aimg01.png"));
            fileList.push(new File("/test/Bimg01.png"));
            fileList.push(new File("/test/Cimg01.png"));

            imageElementConverter.FileList = fileList;

            var testXML1:XML = new XML("<scenario>  <image a=\"Aimg01\" c=\"Cimg01\" x=\"-100\" scale=\"2.0\" rotation=\"20\" backgroundColor=\"0xa\" statusInherit=\"true\" target=\"front\"/> <image a=\"Aimg02\" target=\"main\" /> </scenario>");
            var scenario1:Scenario = new Scenario();

            imageElementConverter.convert(testXML1, scenario1);

            Assert.areEqual(scenario1.ImagerOrders[0].names[0], "Aimg01");
            Assert.areEqual(scenario1.ImagerOrders[0].names[1], "");

            Assert.areEqual(scenario1.ImagerOrders[0].x, -100);
            Assert.areEqual(scenario1.ImagerOrders[0].y, 0);
            Assert.areEqual(scenario1.ImagerOrders[0].Scale, 2.0);
            Assert.areEqual(scenario1.ImagerOrders[0].rotation, 20);
            Assert.areEqual(scenario1.ImagerOrders[0].backgroundColor, 10);
            Assert.isTrue(scenario1.ImagerOrders[0].statusInherit);
            Assert.areEqual(scenario1.ImagerOrders[0].targetLayerIndex, 3);

            Assert.areEqual(scenario1.ImagerOrders.length, 2);

            Assert.isFalse(scenario1.ImagerOrders[1].statusInherit);
            Assert.areEqual(scenario1.ImagerOrders[1].rotation, 0);

            Assert.areEqual(scenario1.ImagerOrders[0].indexes.length, 3);

            Assert.areEqual(scenario1.ImagerOrders[0].indexes[0], 1);
            Assert.areEqual(scenario1.ImagerOrders[0].indexes[1], 0);
            Assert.areEqual(scenario1.ImagerOrders[0].indexes[2], 3);
        }
    }
}
