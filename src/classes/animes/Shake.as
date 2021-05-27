package classes.animes {
    import flash.display.DisplayObject;
    import flash.geom.Point;

    public class Shake implements IAnimation {

        public var strength:int = 5;
        public var duration:int = 24;

        private var frameCount:int;
        private var valid:Boolean = true;
        private var target:DisplayObject;
        private var totalMovePosition:Point = new Point(0, 0);

        public function Shake() {

        }

        public function execute():void {
            if (!valid || !target) {
                return;
            }

            var plusOrMinus:int = Math.cos((frameCount * 180) * Math.PI / 180); // 1 or -1 の値がフレーム毎に切り替わって入ります。
            var movePoint:Point = new Point(strength * plusOrMinus, strength * plusOrMinus);

            target.x += movePoint.x;
            target.y += movePoint.y;
            totalMovePosition = totalMovePosition.add(movePoint);
            frameCount++;
        }

        public function stop():void {
            valid = false;
            frameCount = 0;
            totalMovePosition = new Point(0, 0);
            target.x -= totalMovePosition.x;
            target.y -= totalMovePosition.y;
            target = null;
        }

        public function get Valid():Boolean {
            return valid;
        }

        public function set Target(targetObject:DisplayObject):void {
            target = targetObject;
        }
    }
}
