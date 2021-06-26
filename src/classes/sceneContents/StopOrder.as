package classes.sceneContents {

    public class StopOrder {

        private var target:String;
        private var index:int;

        public function StopOrder() {

        }

        public function get Target():String {
            return target;
        }

        public function set Target(value:String):void {
            if (AllowedTargetKeywords.concat(AllowedTargetAnimationNames).indexOf(value) == -1) {
                throw new ArgumentError("不正なキーワードの入力 (" + value + ") AllowedTargetKeywords に含まれる値を入力してください。");
            }

            target = value;
        }

        public function get Index():int {
            return index;
        }

        public function set Index(value:int):void {
            index = value;
        }

        public function get AllowedTargetKeywords():Vector.<String> {
            return new <String>["bgm", "se", "voice", "backVoice"];
        }

        public function get AllowedTargetAnimationNames():Vector.<String> {
            return new <String>["alphaChanger", "slide", "shake"];
        }
    }
}
