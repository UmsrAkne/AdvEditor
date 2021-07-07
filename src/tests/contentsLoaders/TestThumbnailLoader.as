package tests.contentsLoaders {

    import classes.contentsLoaders.ThumbnailLoader;
    import flash.filesystem.File;

    public class TestThumbnailLoader {
        public function TestThumbnailLoader() {
            test();
        }

        private function test():void {
            var loader:ThumbnailLoader = new ThumbnailLoader(new File(File.applicationDirectory.nativePath).resolvePath("../scenarios/sampleScenario"));
        }
    }
}
