package tests.contentsLoaders.xmlElements {

    import classes.contentsLoaders.xmlElements.SEElementConverter;
    import flash.filesystem.File;
    import classes.sceneContents.Scenario;
    import tests.Assert;

    public class TestSEElementConverter {
        public function TestSEElementConverter() {
            testConvert();
        }

        private function testConvert():void {
            var seElementConverter:SEElementConverter = new SEElementConverter(new File(File.applicationDirectory.nativePath));
            var fileList:Vector.<File> = new Vector.<File>();

            var testDirectory:File = new File(File.applicationDirectory.nativePath);
            fileList.push(testDirectory.resolvePath("/ses/se1.mp3"));
            fileList.push(testDirectory.resolvePath("/ses/se2.mp3"));
            fileList.push(testDirectory.resolvePath("/ses/se3.mp3"));

            seElementConverter.FileList = fileList;

            var xml1:XML = new XML("<scenario> <se number=\"1\" volume=\"0.5\" repeatCount=\"3\"/> </scenario>")
            var xml2:XML = new XML("<scenario> <se fileName=\"se2\" volume=\"0.5\" repeatCount=\"3\"/> </scenario>")

            var scenario1:Scenario = new Scenario();
            var scenario2:Scenario = new Scenario();

            seElementConverter.convert(xml1, scenario1);
            Assert.areEqual(scenario1.SE.Index, 1);
            Assert.areEqual(scenario1.SE.Volume, 0.5);
            Assert.areEqual(scenario1.SERepeatCount, 3);

            seElementConverter.convert(xml2, scenario2);
            Assert.areEqual(scenario2.SE.FileName, "se2.mp3");
        }
    }
}
