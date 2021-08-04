package classes.animes {

    import flash.display.DisplayObject;
    import flash.geom.Rectangle;
    import flash.geom.Point;
    import flash.display.Stage;

    public class LoopSlide implements IAnimation {

        public var interval:int;
        public var distance:int;
        public var reflectCount:int;

        private var intervalCounter:int;
        private var target:DisplayObject;
        private var targetLayerIndex:int = 1;
        private var valid:Boolean = true;
        private var deg:int;
        private var spd:Number = 1.0;
        private var slide:Slide;
        private var stageRect:Rectangle;
        private var couldNotMoveCounter:int;
        private var isConstantVelocitySlide:Boolean;

        public function LoopSlide() {
        }

        public function execute():void {
            if (!valid) {
                return;
            }

            if (intervalCounter > 0) {
                intervalCounter--;
                return;
            }

            if (!slide) {
                slide = new Slide();
                slide.Target = target;
                slide.degree = deg;
                slide.speed = spd;
                slide.isConstantVelocity = isConstantVelocitySlide;
                slide.distance = (distance == 0) ? measureMovableDistance() : distance;
                if (slide.distance == 0) {
                    couldNotMoveCounter++;
                    slide.speed = 0;
                } else {
                    couldNotMoveCounter = 0;
                    reflectCount--;
                }

                // reflectCount = 0 で始まった場合は、最初の slide 生成時に -1 されるため、
                // reflectCount < 0 とした場合は、最初の段階で stop() に到達するため、全く動作せず止まってしまう。
                // このため、 < 0 ではなく < -1 としている。
                if (couldNotMoveCounter >= 5 || reflectCount < -1) {
                    stop();
                    return;
                }
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

            var radian:Number = (deg + 270) * Math.PI / 180;
            var dx:Number = Math.cos(radian);
            dx = Math.round(100 * dx) / 100;

            var dy:Number = Math.sin(radian);
            dy = Math.round(100 * dy) / 100;

            if (!targetRect.containsRect(stageRect)) {
                // target に stage が収まっていない。つまり画像がはみ出しているので動かせない。

                // 一度目のチェックで target に stage が収まっていない場合に関しては、
                // Shake 等のアニメーションで数px だけはみ出している（が正常な位置)という状況があり得る。
                // そこで、動かす予定の方向に少しだけ target をずらして再度チェックする。
                // それで収まっている場合は、その方向に動かせることが確定するため値を戻して処理を続行する。

                targetRect.x += dx * 15;
                targetRect.y += dy * 15;

                if (!targetRect.containsRect(stageRect)) {
                    return 0;
                } else {
                    targetRect.x = target.x;
                    targetRect.y = target.y;
                }
            }

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
            // ターゲットがステージの子かどうかを調べて、可能ならばステージのサイズを取得する。
            var d:DisplayObject = targetObject;

            while (true) {
                if (d.parent) {
                    d = d.parent;
                    if (d is Stage) {
                        stageRect = new Rectangle(0, 0, Stage(d).stageWidth, Stage(d).stageHeight);
                        break;
                    }
                } else {
                    break;
                }
            }

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

        public function set isConstantVelocity(value:Boolean):void {
            isConstantVelocitySlide = value;
        }

        public function set StageRect(value:Rectangle):void {
            stageRect = value;
        }
    }
}
