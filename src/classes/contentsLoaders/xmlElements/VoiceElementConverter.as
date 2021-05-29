package classes.contentsLoaders.xmlElements {

    import classes.sceneContents.SoundFile;
    import flash.filesystem.File;

    public class VoiceElementConverter implements IXMLElementConverter {

        private static const NUMBER_ATTRIBUTE:String = "@number";
        private static const FILE_NAME_ATTRIBUTE:String = "@fileName";

        public function VoiceElementConverter() {
        }

        public function get ElementName():String {
            return "voice";
        }

        public function convert(scenarioElement:XML):* {
            if (!scenarioElement.hasOwnProperty([ElementName])) {
                return;
            }

            var voiceTag:XML = scenarioElement[ElementName][0];
            var soundFile:SoundFile;

            if (voiceTag.hasOwnProperty(FILE_NAME_ATTRIBUTE)) {
                soundFile = new SoundFile();
                soundFile.FileName = voiceTag[FILE_NAME_ATTRIBUTE];
                return soundFile;
            }

            if (voiceTag.hasOwnProperty(NUMBER_ATTRIBUTE)) {
                soundFile = new SoundFile();
                soundFile.Index = voiceTag[NUMBER_ATTRIBUTE];
                return soundFile;
            }

            throw new ArgumentError("voice 要素には number か fileName 属性が必須です");
        }
    }
}
