package classes.contentsLoaders.xmlElements {

    import classes.sceneContents.Scenario;
    import classes.sceneContents.SoundFile;
    import flash.filesystem.File;
    import flash.utils.Dictionary;

    public class BGMElementConverter implements IXMLElementConverter {

        public static const NUMBER_ATTRIBUTE:String = "@number";
        public static const FILE_NAME_ATTRIBUTE:String = "@fileName";
        public static const VOLUME_ATTRIBUTE:String = "@volume";

        private var commonResourceDirectory:File;
        private var fileList:Vector.<File>;
        private var fileByFileNameDictionary:Dictionary = new Dictionary();

        public function BGMElementConverter(commonResourceDirectory:File) {
            this.commonResourceDirectory = commonResourceDirectory;
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

        /**
         *  最初は private function get FileList() で宣言してが、エラーの表示が無いにも関わらずビルドに失敗するので getter ライクな命名で。
         *  ActionScript3.0 のバグか？
         * @return
         */
        private function getFileList():Vector.<File> {
            if (fileList != null) {
                return fileList;
            }

            var fileVec:Vector.<File> = new Vector.<File>();
            var files:Array = commonResourceDirectory.resolvePath("bgms").getDirectoryListing();
            for (var i:int = 0; i < files.length; i++) {
                fileVec.push(files[i]);
            }

            FileList = fileVec;

            return fileList;
        }

        public function get ElementName():String {
            return "bgm";
        }

        public function convert(scenarioElement:XML, scenario:Scenario):void {
            if (!scenarioElement.hasOwnProperty(ElementName)) {
                return;
            }

            var bgmTag:XML = scenarioElement[ElementName][0];
            var soundFile:SoundFile;

            if (!isNaN(parseInt(bgmTag[NUMBER_ATTRIBUTE]))) {
                var index:int = parseInt(bgmTag[NUMBER_ATTRIBUTE]);
                soundFile = new SoundFile(getFileList()[index]);
                soundFile.Index = index;
            }

            if (bgmTag.hasOwnProperty(FILE_NAME_ATTRIBUTE)) {
                var fileName:String = bgmTag[FILE_NAME_ATTRIBUTE];
                soundFile = new SoundFile(fileByFileNameDictionary[fileName]);
                soundFile.FileName = fileName;
            }

            if (bgmTag.hasOwnProperty(VOLUME_ATTRIBUTE)) {
                if (!isNaN(parseFloat(bgmTag[VOLUME_ATTRIBUTE]))) {
                    soundFile.Volume = parseFloat(bgmTag[VOLUME_ATTRIBUTE]);
                }
            }

            scenario.BGM = soundFile;

            if (soundFile == null) {
                throw new ArgumentError("bgm要素には、number か fileName 属性が必須です。");
            }
        }
    }
}
