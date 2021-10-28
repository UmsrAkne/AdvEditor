package tests.sceneContents {

    import classes.sceneContents.ImageFile;
    import flash.filesystem.File;

    public class TestImageFile {
        public function TestImageFile() {
            test();
        }

        private function test():void {
            var imageFile:ImageFile = new ImageFile(new File("/testPath"));
        }
    }
}
