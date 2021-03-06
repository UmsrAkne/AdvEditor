package classes.sceneContents {

    import classes.animes.IAnimation;
    import flash.display.Shape;
    import flash.filesystem.File;

    public class Scenario {

        private var ignore:Boolean;
        private var chapterName:String;
        private var entryPoint:Boolean;

        private var text:String;
        private var textAddition:Boolean;
        private var imageOrders:Vector.<ImageOrder> = new Vector.<ImageOrder>();
        private var drawingOrder:Vector.<ImageOrder> = new Vector.<ImageOrder>();
        private var masks:Vector.<MaskOrder> = new Vector.<MaskOrder>();
        private var animations:Vector.<IAnimation> = new Vector.<IAnimation>();
        private var voice:SoundFile;
        private var se:SoundFile;
        private var seRepeatCount:int;
        private var bgm:SoundFile;
        private var bgvOrders:Vector.<BGVOrder> = new Vector.<BGVOrder>();
        private var stopOrders:Vector.<StopOrder> = new Vector.<StopOrder>();
        private var movieFiles:Vector.<File> = new Vector.<File>();

        public function get Ignore():Boolean {
            return ignore;
        }

        public function set Ignore(value:Boolean):void {
            ignore = value;
        }

        public function get ChapterName():String {
            return chapterName;
        }

        public function set ChapterName(value:String):void {
            chapterName = value;
        }

        public function get EntryPoint():Boolean {
            return entryPoint;
        }

        public function set EntryPoint(value:Boolean):void {
            entryPoint = value;
        }

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

        public function get ImageOrders():Vector.<ImageOrder> {
            return imageOrders;
        }

        public function get DrawingOrder():Vector.<ImageOrder> {
            return drawingOrder;
        }

        public function get Masks():Vector.<MaskOrder> {
            return masks;
        }

        public function get Animations():Vector.<IAnimation> {
            return animations;
        }

        public function set Voice(value:SoundFile):void {
            voice = value;
        }

        public function get Voice():SoundFile {
            return voice;
        }

        public function set SE(value:SoundFile):void {
            se = value;
        }

        public function get SE():SoundFile {
            return se;
        }

        public function set SERepeatCount(value:int):void {
            seRepeatCount = value;
        }

        public function get SERepeatCount():int {
            return seRepeatCount;
        }

        public function set BGM(value:SoundFile):void {
            bgm = value;
        }

        public function get BGM():SoundFile {
            return bgm;
        }

        public function set BGVOrders(value:Vector.<BGVOrder>):void {
            bgvOrders = value;
        }

        public function get BGVOrders():Vector.<BGVOrder> {
            return bgvOrders;
        }

        public function get StopOrders():Vector.<StopOrder> {
            return stopOrders;
        }

        public function get MovieFiles():Vector.<File> {
            return movieFiles;
        }
    }
}
