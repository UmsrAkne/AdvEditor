package classes.contentsLoaders.xmlElements {

    import classes.sceneContents.SoundFile;
    import flash.filesystem.File;
    import classes.sceneContents.Scenario;

    public class VoiceElementConverter implements IXMLElementConverter {

        private static const NUMBER_ATTRIBUTE:String = "@number";
        private static const FILE_NAME_ATTRIBUTE:String = "@fileName";
        private static const CHANNEL_ATTRIBUTE:String = "@channel"

        private var voiceDirectory:File;
        private var voiceFileList:Array;

        public function VoiceElementConverter(sceneDirectory:File) {
            voiceDirectory = new File(sceneDirectory.nativePath + "/voices");
            voiceFileList = voiceDirectory.getDirectoryListing();
        }

        public function get ElementName():String {
            return "voice";
        }

        public function convert(scenarioElement:XML, scenario:Scenario):void {
            if (!scenarioElement.hasOwnProperty([ElementName])) {
                return;
            }

            var voiceTag:XML = scenarioElement[ElementName][0];
            var soundFile:SoundFile;

            if (voiceTag.hasOwnProperty(FILE_NAME_ATTRIBUTE)) {
                var voiceFilePath:String = voiceDirectory.nativePath + "/" + (voiceTag[FILE_NAME_ATTRIBUTE]);
                soundFile = new SoundFile(new File(voiceFilePath));
                scenario.Voice = soundFile;
            }

            if (voiceTag.hasOwnProperty(NUMBER_ATTRIBUTE)) {
                var index:int = parseInt(voiceTag[NUMBER_ATTRIBUTE]);

                // 入力は外部の XML から来るので、変換失敗はあり得るが、
                // 失敗した場合、そのまま処理を続行することはできない（正しく動作しない）ので例外を投げる。
                if (isNaN(parseInt(voiceTag[NUMBER_ATTRIBUTE]))) {
                    throw new Error(" voice のインデックスの変換に失敗しました [" + voiceTag[NUMBER_ATTRIBUTE] + "] is NaN.");
                }

                if (index == 0) {
                    // index 0 番はサウンド無指定と同等
                    return;
                }

                soundFile = new SoundFile(voiceFileList[index]);
                soundFile.Index = voiceTag[NUMBER_ATTRIBUTE];
                scenario.Voice = soundFile;
            }

            if (voiceTag.hasOwnProperty(CHANNEL_ATTRIBUTE)) {
                soundFile.CharacterChannel = parseInt(voiceTag[CHANNEL_ATTRIBUTE])
            }
        }
    }
}
