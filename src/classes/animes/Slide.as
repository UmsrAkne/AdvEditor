package classes.animes {

    import flash.display.DisplayObject;
    import flash.geom.Point;

    public class Slide implements IAnimation {

        public var degree:int;
        public var speed:Number = 0;
        public var distance:int;

        /** アニメーション開始から終了までスピードが一定であるかどうかを設定、取得します。
         *  true に設定した場合、開始直後に低速から加速。終了前に減速するようになります。
         */
        public var isConstantVelocity:Boolean = false;

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

            if (frameCount == 0) {

                // 270度を加算しているのは、計算の起点を３時地点から１２時地点に修正するため
                var radian:Number = (degree + 270) * Math.PI / 180;

                var dx:Number = Math.cos(radian) * speed;
                var dy:Number = Math.sin(radian) * speed;

                spd = new Point(dx, dy);

                if (spd.equals(new Point(0, 0))) {
                    stop();
                }

                beginningEndPoint = Math.min(50, distance * 0.1);
                endingStartPoint = Math.max(distance * 0.85, distance - 60);
            }

            var actualSpeedX:Number = spd.x;
            var actualSpeedY:Number = spd.y;
            var deg:Number;
            var resistance:Number = 1.0;

            // アニメーション開始付近では速度を徐々に早くする。
            if (totalMovingDistance < beginningEndPoint && !isConstantVelocity) {
                deg = 90 / beginningEndPoint;
                resistance = Math.sin(frameCount * deg * Math.PI / 180);
                actualSpeedX *= resistance;
                actualSpeedY *= resistance;
            }


            // アニメーションの終了付近では速度を徐々に遅くする。
            if (totalMovingDistance > endingStartPoint && !isConstantVelocity) {
                endingFrameCount++;

                // cos 75度 = 約 0.25
                // 速度が半分になるまで cos の値を使って減速。
                // 75度を超えたら( 値が 0.5 より小さくなる地点まで来たら ) 75度を維持する。

                deg = 75 / (distance - endingStartPoint) * speed;
                deg = Math.min(75, deg * endingFrameCount);
                resistance = Math.cos(deg * Math.PI / 180);
                actualSpeedX = resistance * actualSpeedX;
                actualSpeedY = resistance * actualSpeedY;
            }

            actualSpeedX = (Math.abs(actualSpeedX) < 0.001) ? 0 : actualSpeedX;
            actualSpeedY = (Math.abs(actualSpeedY) < 0.001) ? 0 : actualSpeedY;

            target.x += actualSpeedX;
            target.y += actualSpeedY;

            var rounded:Number = Math.floor(speed * resistance * 100);
            totalMovingDistance += rounded / 100;
            totalMovingDistance *= 100;
            totalMovingDistance = Math.floor(totalMovingDistance);
            totalMovingDistance /= 100;

            frameCount++;

            if (totalMovingDistance >= distance) {
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

        public function set direction(d:String):void {
            switch (d) {
                case "up":
                    degree = 0;
                    break;

                case "rightUp":
                    degree = 45;
                    break;

                case "right":
                    degree = 90;
                    break;

                case "rightDown":
                    degree = 135;
                    break;

                case "down":
                    degree = 180;
                    break;

                case "leftDown":
                    degree = 225;
                    break;

                case "left":
                    degree = 270;
                    break;

                case "leftUP":
                    degree = 315;
                    break;

                default:
                    break;
            }
        }
    }
}
