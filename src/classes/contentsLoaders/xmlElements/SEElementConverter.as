package classes.contentsLoaders.xmlElements {

    import classes.sceneContents.Scenario;
    import flash.filesystem.File;
    import classes.sceneContents.SoundFile;
    import flash.utils.Dictionary;

    public class SEElementConverter implements IXMLElementConverter {

        public static const NUMBER_ATTRIBUTE:String = "@number";
        public static const FILE_NAME_ATTRIBUTE:String = "@fileName";
        public static const REPEAT_COUNT_ATTRIBUTE:String = "@repeatCount";
        public static const VOLUME_ATTRIBUTE:String = "@volume";

        private var commonResourceDirectory:File;
        private var fileList:Vector.<File>;
        private var fileByFileNameDictionary:Dictionary = new Dictionary();

        public function SEElementConverter(commonResourceDirectory:File) {
            this.commonResourceDirectory = commonResourceDirectory;
        }

        public function get ElementName():String {
            return "se";
        }

        /**
         * テスト用メソッド
         * @param value
         */
        public function set FileList(value:Vector.<File>):void {
            if (fileList == null) {
                fileList = value;

                for each (var f:File in fileList) {
                    fileByFileNameDictionary[f.name] = f;
                    fileByFileNameDictionary[f.name.split(".")[0]] = f;
                }
            }
        }

        public function convert(scenarioElement:XML, scenario:Scenario):void {
            if (!scenarioElement.hasOwnProperty(ElementName)) {
                return;
            }

            var seTag:XML = scenarioElement[ElementName][0];
            var soundFile:SoundFile;

            if (!isNaN(parseInt(seTag[NUMBER_ATTRIBUTE]))) {
                var index:int = parseInt(seTag[NUMBER_ATTRIBUTE]);
                soundFile = new SoundFile(getFileList()[index]);
                soundFile.Index = index;
            }

            if (seTag.hasOwnProperty(FILE_NAME_ATTRIBUTE)) {
                var fileName:String = seTag[FILE_NAME_ATTRIBUTE];
                soundFile = new SoundFile(fileByFileNameDictionary[fileName]);
                soundFile.FileName = fileName;
            }

            if (seTag.hasOwnProperty(VOLUME_ATTRIBUTE)) {
                if (!isNaN(parseFloat(seTag[VOLUME_ATTRIBUTE]))) {
                    soundFile.Volume = parseFloat(seTag[VOLUME_ATTRIBUTE]);
                }
            }

            if (seTag.hasOwnProperty(REPEAT_COUNT_ATTRIBUTE)) {
                scenario.SERepeatCount = parseInt(seTag[REPEAT_COUNT_ATTRIBUTE]);
            }

            scenario.SE = soundFile;

            if (soundFile == null) {
                throw new ArgumentError("se要素には、number か fileName 属性が必須です。");
            }
        }


        private function getFileList():Vector.<File> {
            if (fileList != null) {
                return fileList;
            }

            var fileVec:Vector.<File> = new Vector.<File>();
            var files:Array = commonResourceDirectory.resolvePath("ses").getDirectoryListing();
            for (var i:int = 0; i < files.length; i++) {
                fileVec.push(files[i]);
            }

            FileList = fileVec;

            return fileList;
        }

    }
}
