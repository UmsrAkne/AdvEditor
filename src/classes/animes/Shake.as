package classes.animes {
    import flash.display.DisplayObject;
    import flash.geom.Point;

    public class Shake implements IAnimation {

        public var strength:int = 5;
        public var duration:int = 24;
        public var loopCount:int;

        private var intervalCount:int;
        private var originalIntervalCount:int;
        private var degree:int = 0;
        private var distance:Point = new Point(0, 0);

        private var frameCount:int;
        private var valid:Boolean = true;
        private var target:DisplayObject;
        private var targetLayerIndex:int = 1;
        private var totalMovePosition:Point = new Point(0, 0);
        private var originalTargetPosition:Point = new Point(0, 0);

        private function getResistance(counter:int):Number {
            var deg:Number = 90 / duration;
            return Math.cos(counter * deg * Math.PI / 180);
        }

        public function Shake() {

        }

        public function execute():void {
            if (!valid || !target) {
                return;
            }

            if (intervalCount > 0) {
                intervalCount--;
                return;
            }

            degree = getRandomDegree(degree);
            var adjust:Number = Math.random() + 0.1;
            var rad:Number = degree * Math.PI / 180;
            distance = new Point(Math.sin(rad) * strength * adjust, Math.cos(rad) * strength * adjust);

            if (frameCount != 0) {
                distance.x *= 2;
                distance.y *= 2;
            }

            distance.x = Math.floor(distance.x * 100) / 100;
            distance.y = Math.floor(distance.y * 100) / 100;

            target.x += distance.x;
            target.y += distance.y;
            totalMovePosition = totalMovePosition.add(distance);
            frameCount++;

            if (frameCount >= duration) {
                if (loopCount <= 0) {
                    stop();
                } else {
                    frameCount = 0;
                    target.x -= totalMovePosition.x;
                    target.y -= totalMovePosition.y;
                    target.x = Math.round(target.x);
                    target.y = Math.round(target.y);
                    totalMovePosition = new Point(0, 0);
                    loopCount--;
                    intervalCount = originalIntervalCount;
                }
            }
        }

        public function stop():void {
            valid = false;
            frameCount = 0;
            target.x -= totalMovePosition.x;
            target.y -= totalMovePosition.y;
            target.x = Math.round(target.x);
            target.y = Math.round(target.y);
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

        public function set interval(value:int):void {
            originalIntervalCount = value;
        }

        /**
         * 最後に使用した角度の値から、ランダムな角度の値を取得します。
         * @param lastDegree 最後に使用した角度の値を入力します。
         * @return
         */
        private function getRandomDegree(lastDegree:int):int {
            // ほぼ反対側の角度が返却されるようにする。
            return lastDegree + Math.floor(Math.random() * (230 - 130)) + 130;
        }
    }
}
