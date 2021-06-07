package tests.contentsLoaders {

    import classes.contentsLoaders.SettingLoader;
    import flash.filesystem.File;

    public class TestSettingLoader {
        public function TestSettingLoader() {
            testWriteContents();
        }

        private function testWriteContents():void {
            var settingLoader:SettingLoader = new SettingLoader(new File(File.applicationDirectory.nativePath));
        }
    }
}
