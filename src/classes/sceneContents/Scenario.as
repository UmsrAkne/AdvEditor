package classes.sceneContents {

    public class Scenario {

        private var text:String;
        private var textAddition:Boolean;
        private var imageOrders:Vector.<ImageOrder> = new Vector.<ImageOrder>();

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
    }
}
