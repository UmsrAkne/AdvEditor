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
            fileList.push(new File("/test/Dimg01.png"));

            imageElementConverter.FileList = fileList;

            var testXML1:XML = new XML("<scenario>  <image a=\"Aimg01\" c=\"Cimg01\" d=\"Dimg01.png\" x=\"-100\" scale=\"2.0\" rotation=\"20\" backgroundColor=\"0xa\" statusInherit=\"true\" target=\"front\"/> <image a=\"Aimg02\" target=\"main\" /> </scenario>");
            var scenario1:Scenario = new Scenario();

            imageElementConverter.convert(testXML1, scenario1);

            Assert.areEqual(scenario1.ImageOrders[0].names[0], "Aimg01");
            Assert.areEqual(scenario1.ImageOrders[0].names[1], "");

            Assert.areEqual(scenario1.ImageOrders[0].x, -100);
            Assert.areEqual(scenario1.ImageOrders[0].y, 0);
            Assert.areEqual(scenario1.ImageOrders[0].Scale, 2.0);
            Assert.areEqual(scenario1.ImageOrders[0].rotation, 20);
            Assert.areEqual(scenario1.ImageOrders[0].backgroundColor, 10);
            Assert.isTrue(scenario1.ImageOrders[0].statusInherit);
            Assert.areEqual(scenario1.ImageOrders[0].targetLayerIndex, 3);

            Assert.areEqual(scenario1.ImageOrders.length, 2);

            Assert.isFalse(scenario1.ImageOrders[1].statusInherit);
            Assert.areEqual(scenario1.ImageOrders[1].rotation, 0);

            Assert.areEqual(scenario1.ImageOrders[0].indexes.length, 4);

            Assert.areEqual(scenario1.ImageOrders[0].indexes[0], 1);
            Assert.areEqual(scenario1.ImageOrders[0].indexes[1], 0);
            Assert.areEqual(scenario1.ImageOrders[0].indexes[2], 3);
            Assert.areEqual(scenario1.ImageOrders[0].indexes[3], 4);

            var testXML2:XML = new XML("<scenario>  <image a=\"Aimg01\" c=\"Cimg01\" scale=\"\" backgroundColor=\"0xa\" statusInherit=\"true\" target=\"front\"/>  </scenario>");
            var scenario2:Scenario = new Scenario();

            // scale="" のように空白を入力しても例外が出ないかどうかを確認する。
            imageElementConverter.convert(testXML2, scenario2);
        }
    }
}
