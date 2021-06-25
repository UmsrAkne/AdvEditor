package tests.contentsLoaders.xmlElements {

    import classes.contentsLoaders.xmlElements.BackVoiceElementConverter;
    import flash.filesystem.File;

    public class TestBackVoiceElementConverter {
        public function TestBackVoiceElementConverter() {
            test();
        }

        private function test():void {
            var bgVoiceElementConverter:BackVoiceElementConverter = new BackVoiceElementConverter(File.applicationDirectory);
        }
    }
}
