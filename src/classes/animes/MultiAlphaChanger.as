package classes.animes {

    import flash.display.DisplayObject;

    public class MultiAlphaChanger implements IAnimation {

        private var valid:Boolean = true;
        private var frontTarget:DisplayObject;
        private var backTargets:DisplayObject;
        private var targetLayerIndex:int;

        public function MultiAlphaChanger() {
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
            return "alphaChanger";
        }

        public function set Target(targetObject:DisplayObject):void {
            frontTarget = targetObject;
        }

        public function set TargetLayerIndex(index:int):void {
            targetLayerIndex = index;
        }

        public function get TargetLayerIndex():int {
            return targetLayerIndex;
        }
    }
}
