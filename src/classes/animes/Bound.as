package classes.animes {

    import flash.display.DisplayObject;

    public class Bound implements IAnimation {

        private var targetLayerIndex:int = 1;
        private var target:DisplayObject;
        private var valid:Boolean = true;
        private var frameCount:int;

        public function execute():void {
            if (!valid) {
                return;
            }
        }

        public function stop():void {
            valid = false;
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
