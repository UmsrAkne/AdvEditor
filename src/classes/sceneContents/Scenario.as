package classes.sceneContents {

    public class Scenario {

        private var text:String;
        private var textAddition:Boolean;
        private var imageOrders:Vector.<ImageOrder> = new Vector.<ImageOrder>();
        private var voice:SoundFile;
        private var bgm:SoundFile;

        public function get Text():String {
            return text;
        }

        public function set Text(value:String):void {
            text = value;
        }

        /**
         * テキストウィンドウに対するテキストの書き込みタイプを取得します。
         * @return
         */
        public function get TextAddition():Boolean {
            return textAddition;
        }

        /**
         * テキストウィンドウに対するテキストの書き込みタイプを設定します。
         * このプロパティが true にセットされている場合、既に書かれたテキストウィンドウのテキストに、新しいテキストを加筆するように書き込みます。
         * @param value
         */
        public function set TextAddition(value:Boolean):void {
            textAddition = value;
        }

        public function get ImagerOrders():Vector.<ImageOrder> {
            return imageOrders;
        }

        public function set Voice(value:SoundFile):void {
            voice = value;
        }

        public function get Voice():SoundFile {
            return voice;
        }

        public function set BGM(value:SoundFile):void {
            bgm = value;
        }

        public function get BGM():SoundFile {
            return bgm;
        }

    }
}
