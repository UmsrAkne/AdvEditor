package classes.animes {

    import flash.display.DisplayObject;
    import flash.geom.Point;

    public class Slide implements IAnimation {

        public var degree:int;
        public var speed:Number = 0;
        public var distance:int;

        private var spd:Point;
        private var targetLayerIndex:int;
        private var target:DisplayObject;
        private var valid:Boolean = true;
        private var totalMovingDistance:int = 0;

        public function execute():void {
            if (!Valid) {
                stop();
                return;
            }

            if (spd == null) {

                // 270度を加算しているのは、計算の起点を３時地点から１２時地点に修正するため
                var radian:Number = (degree + 270) * Math.PI / 180;

                var x:int = Math.cos(radian) * speed * 100;
                var y:int = Math.sin(radian) * speed * 100;

                spd = new Point(x / 100, y / 100);

                if (spd.equals(new Point(0, 0))) {
                    stop();
                }
            }

            target.x += spd.x;
            target.y += spd.y;
            totalMovingDistance += speed;

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
