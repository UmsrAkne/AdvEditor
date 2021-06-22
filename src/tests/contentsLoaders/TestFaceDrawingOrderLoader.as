package tests.contentsLoaders {

    import classes.contentsLoaders.FaceDrawingOrderLoader;
    import flash.filesystem.File;

    public class TestFaceDrawingOrderLoader {
        public function TestFaceDrawingOrderLoader() {
            test();
        }

        private function test():void {
            var faceDrawingOrderLoader:FaceDrawingOrderLoader = new FaceDrawingOrderLoader(new File(File.applicationDirectory.nativePath));
        }
    }
}
