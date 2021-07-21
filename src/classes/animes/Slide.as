package classes.animes {

    import flash.display.DisplayObject;
    import flash.geom.Point;

    public class Slide implements IAnimation {

        public var degree:int;
        public var speed:Number = 0;
        public var distance:int;

        private var spd:Point;
        private var targetLayerIndex:int = 1;
        private var target:DisplayObject;
        private var valid:Boolean = true;
        private var totalMovingDistance:Number = 0;

        private var beginningEndPoint:int;
        private var endingStartPoint:int;
        private var frameCount:int;
        private var endingFrameCount:int;

        public function execute():void {
            if (!Valid) {
                stop();
                return;
            }

            frameCount++;

            if (spd == null) {

                // 270度を加算しているのは、計算の起点を３時地点から１２時地点に修正するため
                var radian:Number = (degree + 270) * Math.PI / 180;

                var x:int = Math.cos(radian) * speed * 100;
                var y:int = Math.sin(radian) * speed * 100;

                spd = new Point(x / 100, y / 100);

                if (spd.equals(new Point(0, 0))) {
                    stop();
                }

                beginningEndPoint = Math.min(40, distance * 0.1);
                endingStartPoint = Math.max(distance * 0.9, distance - 40);
            }

            var actualSpeedX:Number = spd.x;
            var actualSpeedY:Number = spd.y;
            var deg:Number;
            var resistance:Number = 1.0;

            // アニメーション開始付近では速度を徐々に早くする。
            if (totalMovingDistance < beginningEndPoint) {
                deg = 90 / beginningEndPoint;
                resistance = Math.sin(frameCount * deg * Math.PI / 180);
                actualSpeedX *= resistance;
                actualSpeedY *= resistance;
            }

            // アニメーションの終了付近では速度を徐々に遅くする。
            if (totalMovingDistance > endingStartPoint) {
                endingFrameCount++;

                // cos 60度 = 約 0.5 
                // 速度が半分になるまで cos の値を使って減速。
                // 60度を超えたら( 値が 0.5 より小さくなる地点まで来たら ) 60度を維持する。

                deg = 60 / (distance - endingStartPoint);
                deg = Math.min(60, deg * endingFrameCount);
                resistance = Math.cos(deg * Math.PI / 180);
                actualSpeedX = resistance * actualSpeedX;
                actualSpeedY = resistance * actualSpeedY;
            }

            target.x += actualSpeedX;
            target.y += actualSpeedY;

            var rounded:Number = Math.floor(speed * resistance * 100);
            totalMovingDistance += rounded / 100;
            totalMovingDistance *= 100;
            totalMovingDistance = Math.floor(totalMovingDistance);
            totalMovingDistance /= 100;

            if (totalMovingDistance > distance) {
                stop();
            }
        }

        public function stop():void {
            valid = false;
        }

        public function get Valid():Boolean {
            return valid;
        }

        public function get AnimationName():String {
            return "slide";
        }

        public function set Target(targetObject:DisplayObject):void {
            if (target == null) {
                target = targetObject;
            }
        }

        public function set TargetLayerIndex(index:int):void {
            targetLayerIndex = index;
        }

        public function get TargetLayerIndex():int {
            return targetLayerIndex;
        }
    }
}
