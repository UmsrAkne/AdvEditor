package classes.animes {

    import flash.display.DisplayObject;
    import flash.geom.Point;

    public class Bound implements IAnimation {

        public var degree:int;
        public var duration:int = 8;
        public var strength:int = 1;

        private var targetLayerIndex:int = 1;
        private var target:DisplayObject;
        private var valid:Boolean = true;
        private var frameCount:int;
        private var totalMoveDistance:Point = new Point(0, 0);

        public function execute():void {
            if (!valid) {
                return;
            }

            var radian:Number = (degree - 90) * (Math.PI / 180);
            var d:Point = new Point(Math.cos(radian) * strength, Math.sin(radian) * strength);

            if (frameCount >= duration / 2) {
                d.x *= -1;
                d.y *= -1;
            }

            target.x += d.x;
            target.y += d.y;
            totalMoveDistance.x += d.x;
            totalMoveDistance.y += d.y;

            frameCount++;

            if (frameCount > duration) {
                stop();
            }
        }

        public function stop():void {
            valid = false;

            // totalMoveDistance の値を引いても丁度 0 にはならないため、 target の座標の小数点以下は丸める
            target.x -= totalMoveDistance.x;
            target.x = Math.round(target.x);
            target.y -= totalMoveDistance.y;
            target.y = Math.round(target.y);

            totalMoveDistance = new Point(0, 0);
        }

        public function get Valid():Boolean {
            return valid;
        }

        public function get AnimationName():String {
            return "bound";
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
    }
}
