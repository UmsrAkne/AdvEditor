package classes.animes {

    import flash.display.DisplayObject;

    public class LoopSlide implements IAnimation {

        private var target:DisplayObject;
        private var targetLayerIndex:int = 1;
        private var valid:Boolean = true;

        public function LoopSlide() {
        }

        public function execute():void {
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
