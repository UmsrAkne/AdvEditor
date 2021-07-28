package classes.contentsLoaders {

    import flash.events.EventDispatcher;

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
