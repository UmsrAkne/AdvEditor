package tests.contentsLoaders.xmlElements {

    import classes.contentsLoaders.xmlElements.ImageElementConverter;
    import flash.filesystem.File;

    public class TestImageElementConverter {
        public function TestImageElementConverter() {
            testConvert();
        }

        private function testConvert():void {
            var imageElementConverter:ImageElementConverter = new ImageElementConverter(new File(File.applicationDirectory.nativePath));
        }
    }
}
