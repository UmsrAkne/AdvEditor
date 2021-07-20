package tests.contentsLoaders {

    import classes.contentsLoaders.SettingLoader;
    import flash.filesystem.File;
    import classes.sceneContents.Resource;
    import tests.Assert;

    public class TestSettingLoader {
        public function TestSettingLoader() {
            testWriteContents();
        }

        private function testWriteContents():void {
            var settingLoader:SettingLoader = new SettingLoader(new File(File.applicationDirectory.nativePath));
            var xmlString:String = "<root><setting ";
            xmlString += "width=\"10\" height=\"20\" x=\"30\" y=\"-40\" ";
            xmlString += "bgm=\"sampleBGM\" ";
            xmlString += "voiceVolume=\"0.5\" backVoiceVolume=\"0.6\" bgmVolume=\"0.7\" seVolume=\"0.8\" ";
            xmlString += "defaultScale=\"2.0\""
            xmlString += "/></root>"
            settingLoader.SettingXML = new XMLList(xmlString);
            var res:Resource = new Resource();
            settingLoader.writeContentsTo(res);

            Assert.areEqual(res.ScreenSize.width, 10);
            Assert.areEqual(res.ScreenSize.height, 20);
            Assert.areEqual(res.ScreenSize.x, 30);
            Assert.areEqual(res.ScreenSize.y, -40);

            Assert.areEqual(res.InitialBGMName, "sampleBGM");
            Assert.areEqual(res.defaultScale, 2.0);

            Assert.areEqual(res.voiceVolume, 0.5);
            Assert.areEqual(res.backVoiceVolume, 0.6);
            Assert.areEqual(res.bgmVolume, 0.7);
            Assert.areEqual(res.seVolume, 0.8);
        }
    }
}
