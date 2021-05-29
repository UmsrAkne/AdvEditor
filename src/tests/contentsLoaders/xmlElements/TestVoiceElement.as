package tests.contentsLoaders.xmlElements {

    import classes.contentsLoaders.xmlElements.VoiceElementConverter;
    import classes.sceneContents.SoundFile;
    import flash.filesystem.File;
    import tests.Assert;

    public class TestVoiceElement {
        public function TestVoiceElement() {
            testConvert();
        }

        private function testConvert():void {
            var xmlList:XMLList = new XMLList("<scenario>" + "<voice fileName=\"testFile\" />" + "</scenario>");
            var xmlList2:XMLList = new XMLList("<scenario>" + "<voice number=\"001\" />" + "</scenario>");
            trace(xmlList.voice["@fileName"]);
            var xml:XML = xmlList.voice[0];
            trace("test");

            var f:File = new File(File.applicationDirectory.nativePath);
            var vc:VoiceElementConverter = new VoiceElementConverter(f.resolvePath("../scenarios/sampleScenario"));

            var soundFFileFromFileName:SoundFile = vc.convert(xmlList[0]);
            Assert.areEqual(soundFFileFromFileName.FileName, "testFile");

            var soundFileFromIndex:SoundFile = vc.convert(xmlList2[0]);
            Assert.areEqual(soundFileFromIndex.FileName, "002.mp3");
        }
    }
}
