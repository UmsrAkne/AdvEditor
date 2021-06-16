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
            settingLoader.SettingXML = new XMLList("<root><setting width=\"10\" height=\"20\" x=\"30\" y=\"-40\" /></root>");
            var res:Resource = new Resource();
            settingLoader.writeContentsTo(res);

            Assert.areEqual(res.ScreenSize.width, 10);
            Assert.areEqual(res.ScreenSize.height, 20);
            Assert.areEqual(res.ScreenSize.x, 30);
            Assert.areEqual(res.ScreenSize.y, -40);
        }
    }
}
