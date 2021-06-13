package classes.animes {

    import flash.display.DisplayObject;

    public class Slide implements IAnimation {

        private var _distance:int;
        private var _speed:Number;
        private var _degree:Number;

        private var targetLayerIndex:int;
        private var target:DisplayObject;
        private var valid:Boolean = true;
        private var totalMovingDistance:Number;

        public function execute():void {
            throw new Error("Method not implemented.");
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

        public function set distance(value:int):void {
            _distance = value;
        }

        public function set speed(value:Number):void {
            _speed = value;
        }

        public function set degree(value:Number):void {
            _degree = value;
        }
    }
}
