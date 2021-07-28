package classes.contentsLoaders {

    import flash.events.EventDispatcher;
    import flash.filesystem.File;
    import flash.filesystem.FileStream;
    import flash.filesystem.FileMode;
    import flash.net.URLRequest;
    import flash.net.URLLoader;
    import flash.events.Event;

    public class Configuration {

        public static var SELECTION_INDEX_ATTRIBUTE:String = "@selectionIndex";
        public static var FULL_SCREEN_MODE_ATTRIBUTE:String = "@fullScreenMode";

        private var selectionIndex:int;
        private var fullScreenMode:Boolean;

        private var completeEventDispatcher:EventDispatcher = new EventDispatcher();
        private var xml:XML;

        public function Configuration() {

        }

        public function get CompleteEventDispatcher():EventDispatcher {
            return completeEventDispatcher;
        }

        /**
         * 読み込んだ XML ファイルから情報を取り出して、このクラスのフィールドに値をセットします。
         */
        private function convert():void {
            var configTag:XML = xml[ElementName][0];

            if (configTag.hasOwnProperty(SELECTION_INDEX_ATTRIBUTE)) {
                if (!isNaN(parseInt(configTag[SELECTION_INDEX_ATTRIBUTE]))) {
                    selectionIndex = parseInt(configTag[SELECTION_INDEX_ATTRIBUTE]);
                }
            }

            if (configTag.hasOwnProperty(FULL_SCREEN_MODE_ATTRIBUTE)) {
                if (configTag[FULL_SCREEN_MODE_ATTRIBUTE] == "true") {
                    fullScreenMode = true;
                }
            }

            completeEventDispatcher.dispatchEvent(new Event(Event.COMPLETE));
        }

        public function load(xmlFilePath:String):void {
            var xmlFile:File = new File(xmlFilePath);
            if (!xmlFile.exists) {
                var stream:FileStream = new FileStream();
                stream.open(xmlFile, FileMode.WRITE);
                var defaultXMLString:String = "<root><" + ElementName + " ";
                defaultXMLString += SELECTION_INDEX_ATTRIBUTE.substr(1) + "=\"0\" ";
                defaultXMLString += FULL_SCREEN_MODE_ATTRIBUTE.substr(1) + "=\"false\"";
                defaultXMLString += "/></root>"

                stream.writeUTFBytes(defaultXMLString);
                stream.close();
            }

            var urlLoader:URLLoader = new URLLoader();
            urlLoader.addEventListener(Event.COMPLETE, function(e:Event):void {
                xml = new XML(URLLoader(e.target).data);
                convert();
            });

            urlLoader.load(new URLRequest(xmlFile.nativePath));
        }

        public function get ElementName():String {
            return "configuration";
        }

        public function get SelectionIndex():int {
            return selectionIndex
        }

        public function get FullScreenMode():Boolean {
            return fullScreenMode;
        }

        /**
         * テスト用セッター
         * @param configXML
         */
        public function setConfigrationXML(configXML:XML):void {
            xml = configXML;
            convert();
        }
    }
}
