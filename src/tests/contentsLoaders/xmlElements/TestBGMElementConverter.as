package tests.contentsLoaders.xmlElements {

    import classes.contentsLoaders.xmlElements.BGMElementConverter;
    import flash.filesystem.File;
    import classes.sceneContents.Scenario;
    import tests.Assert;

    public class TestBGMElementConverter {
        public function TestBGMElementConverter() {
            testConvert();
        }

        private function testConvert():void {
            var bgmElementConverter:BGMElementConverter = new BGMElementConverter(new File(File.applicationDirectory.nativePath));
            var testPath:File = new File(File.applicationDirectory.nativePath);

            var fileList:Vector.<File> = new Vector.<File>();
            fileList.push((testPath.resolvePath("/testDirectory/testSound1.mp3")));
            fileList.push((testPath.resolvePath("/testDirectory/testSound2.mp3")));
            fileList.push((testPath.resolvePath("/testDirectory/testSound3.mp3")));
            fileList.push((testPath.resolvePath("/testDirectory/testSound4.mp3")));

            bgmElementConverter.FileList = fileList;

            var xml1:XML = new XML("<scenario> <bgm number=\"01\" \/></scenario>")
            var xml2:XML = new XML("<scenario> <bgm fileName=\"testSound2\" \/></scenario>")

            var scenario1:Scenario = new Scenario();
            var scenario2:Scenario = new Scenario();

            bgmElementConverter.convert(xml1, scenario1);
            Assert.areEqual(scenario1.BGM.Index, 1);

            bgmElementConverter.convert(xml2, scenario2);
            Assert.areEqual(scenario1.BGM.FileName, "testSound2.mp3");
            ;
        }
    }
}
