package tests.contentsLoaders {

    import classes.contentsLoaders.SoundLoader;
    import flash.filesystem.File;

    public class TestSoundLoader {
        public function TestSoundLoader() {
            testWriteResource();
        }

        private function testWriteResource():void {
            var soundLoader:SoundLoader = new SoundLoader(new File(File.applicationDirectory.nativePath));
        }
    }
}
