package classes.animes {
    import flash.display.DisplayObject;
    import flash.geom.Point;

    public class Shake implements IAnimation {

        public var strength:int = 5;
        public var duration:int = 24;

        private var frameCount:int;
        private var valid:Boolean = true;
        private var target:DisplayObject;
        private var targetLayerIndex:int = 1;
        private var totalMovePosition:Point = new Point(0, 0);

        private function get Resistor():Number {
            // このプロパティの返却値は、最大 1.0 からフレームカウントが大きくなる程 0 に近づきます。
            var deg:Number = 90 / duration;
            return Math.cos(frameCount * deg) * Math.PI / 180;
        }

        public function Shake() {

        }

        public function execute():void {
            if (!valid || !target) {
                return;
            }

            var plusOrMinus:int = Math.cos((frameCount * 180) * Math.PI / 180); // 1 or -1 の値がフレーム毎に切り替わって入ります。
            var value:Number = strength * Resistor * plusOrMinus;

            if (frameCount % 2 != 0) {
                value *= 2;
            }

            value = Math.floor(value * 100);
            var movePoint:Point = new Point(value, value);

            target.x += movePoint.x;
            target.y += movePoint.y;
            totalMovePosition = totalMovePosition.add(movePoint);
            frameCount++;

            if (frameCount >= duration) {
                stop();
            }
        }

        public function stop():void {
            valid = false;
            frameCount = 0;
            target.x -= totalMovePosition.x;
            target.y -= totalMovePosition.y;
            totalMovePosition = new Point(0, 0);
        }

        public function get Valid():Boolean {
            return valid;
        }

        public function get AnimationName():String {
            return "shake";
        }

        /**
         * セットが可能なのは、初回登録時、または execute 未実行の場合のみ。
         * @param targetObject
         */
        public function set Target(targetObject:DisplayObject):void {
            if (!target || frameCount == 0) {
                target = targetObject;
            }
        }

        public function get TargetLayerIndex():int {
            return targetLayerIndex;
        }

        public function set TargetLayerIndex(value:int):void {
            targetLayerIndex = value;
        }
    }
}