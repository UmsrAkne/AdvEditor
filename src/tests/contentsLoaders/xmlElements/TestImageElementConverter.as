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
            var testDirectory:File = new File(File.applicationDirectory.nativePath);
            fileList.push(testDirectory.resolvePath("/images/Aimg01.png"));
            fileList.push(testDirectory.resolvePath("/images/Aimg02.png"));
            fileList.push(testDirectory.resolvePath("/images/Aimg03.png"));

            fileList.push(testDirectory.resolvePath("/images/Bimg01.png"));
            fileList.push(testDirectory.resolvePath("/images/Bimg02.png"));

            fileList.push(testDirectory.resolvePath("/images/Cimg01.png"));
            fileList.push(testDirectory.resolvePath("/images/Cimg02.png"));

            imageElementConverter.FileList = fileList;

            var testXML1:XML = new XML("<scenario>  <image a=\"Aimg01\" c=\"Cimg01\" x=\"-100\" />  </scenario>");
            var scenario1:Scenario = new Scenario

            imageElementConverter.convert(testXML1, scenario1);
            Assert.areEqual(scenario1.ImagerOrders[0].names[0], "Aimg01");
            Assert.areEqual(scenario1.ImagerOrders[0].names[1], "");

            Assert.areEqual(scenario1.ImagerOrders[0].x, -100);
            Assert.areEqual(scenario1.ImagerOrders[0].y, 0);
        }
    }
}
