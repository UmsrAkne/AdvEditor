package tests.sceneContents {

    import classes.sceneContents.ImageFile;
    import flash.filesystem.File;
    import tests.Assert;

    public class TestImageFile {
        public function TestImageFile() {
            test();
        }

        private function test():void {
            var imageFile:ImageFile = new ImageFile(new File("/testPath/image.png"));
            Assert.areEqual(imageFile.FileName, "image.png");
            Assert.areEqual(imageFile.FileNameWithoutExtension, "image");

            var imageFile2:ImageFile = new ImageFile(new File("/testPath/image"));
            Assert.areEqual(imageFile2.FileName, "image");
            Assert.areEqual(imageFile2.FileNameWithoutExtension, "image");
        }
    }
}
