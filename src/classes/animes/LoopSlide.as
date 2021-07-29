package classes.animes {

    import flash.display.DisplayObject;
    import flash.geom.Rectangle;
    import flash.geom.Point;

    public class LoopSlide implements IAnimation {

        public var interval:int;

        private var intervalCounter:int;
        private var target:DisplayObject;
        private var targetLayerIndex:int = 1;
        private var valid:Boolean = true;
        private var deg:int;
        private var spd:Number = 1.0;
        private var slide:Slide;
        private var stageRect:Rectangle;

        public function LoopSlide() {
        }

        public function execute():void {
            if (intervalCounter > 0) {
                intervalCounter--;
                return;
            }

            if (!slide) {
                slide = new Slide();
                slide.Target = target;
                slide.degree = deg;
                slide.speed = spd;
                slide.distance = measureMovableDistance();
            }

            slide.execute();

            if (!slide.Valid) {
                deg += 180;
                slide = null;
                intervalCounter = interval;
            }
        }

        public function stop():void {
            valid = false;
        }

        private function measureMovableDistance():int {
            var targetRect:Rectangle = new Rectangle(target.x, target.y, target.width, target.height);
            if (!targetRect.containsRect(stageRect)) {
                // target に stage が収まっていない。つまり画像がはみ出しているので動かせない。
                return 0;
            }

            var radian:Number = (deg + 270) * Math.PI / 180;
            var dx:Number = Math.cos(radian);
            var dy:Number = Math.sin(radian);

            // オブジェクトが動くことができる値の中での最大値を算出する。
            // (ターゲットの対角線長) - (ステージの対角線長)
            var estimationMaxDistance:Number = Math.sqrt(Math.pow(target.width, 2) + Math.pow(target.height, 2)) - Math.sqrt(Math.pow(stageRect.width, 2) + Math.pow(stageRect.height, 2));

            // 算出した最大値を使用して二分探索を行い、実際にスライド可能な距離を算出する。

            var minDistance:Number = 0;
            var maxDistance:Number = estimationMaxDistance;

            while (true) {
                var s:* = stageRect;
                var originalPos:Point = new Point(targetRect.x, targetRect.y);
                var centerValue:Number = ((maxDistance - minDistance) / 2) + minDistance;
                targetRect.x += dx * centerValue;
                targetRect.y += dy * centerValue;

                if (targetRect.containsRect(stageRect)) {
                    minDistance = centerValue;
                } else {
                    maxDistance = centerValue;
                }

                targetRect.x = originalPos.x;
                targetRect.y = originalPos.y;

                if (maxDistance - minDistance < 1.0) {
                    break;
                }
            }

            return Math.floor(maxDistance);
        }

        public function get Valid():Boolean {
            return valid;
        }

        public function get AnimationName():String {
            return "slide";
        }

        public function set Target(targetObject:DisplayObject):void {
            target = targetObject;
        }

        public function set TargetLayerIndex(index:int):void {
            targetLayerIndex = index;
        }

        public function get TargetLayerIndex():int {
            return targetLayerIndex;
        }

        public function set degree(value:int):void {
            deg = value;
        }

        public function set speed(value:Number):void {
            spd = value;
        }

        public function set StageRect(value:Rectangle):void {
            stageRect = value;
        }
    }
}
