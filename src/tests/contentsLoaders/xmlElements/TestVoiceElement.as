package tests.contentsLoaders.xmlElements {

    import classes.contentsLoaders.xmlElements.VoiceElementConverter;
    import classes.sceneContents.SoundFile;

    public class TestVoiceElement {
        public function TestVoiceElement() {
            testConvert();
        }

        private function testConvert():void {
            var xmlList:XMLList = new XMLList("<scenario>" + "<voice fileName=\"testFile\" />" + "</scenario>");
            trace(xmlList.voice["@fileName"]);
            var xml:XML = xmlList.voice[0];
            trace("test");

            var vc:VoiceElementConverter = new VoiceElementConverter();
            var sf:SoundFile = vc.convert(xmlList[0]);
            trace("");
        }
    }
}
