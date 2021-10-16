package classes.animes {

    import flash.display.DisplayObject;

    public class AlphaChanger implements IAnimation {

        public var duration:int = 12;
        public var amount:Number = 0.1;
        public var delay:int;

        private var frameCount:int;
        private var target:DisplayObject;
        private var valid:Boolean = true;
        private var targetLayerIndex:int = 1;

        public function AlphaChanger() {
        }

        public function execute():void {
            if (!valid || !target) {
                return;
            }

            if (delay > 0) {
                delay--;
                return;
            }

            target.alpha += amount;

            frameCount++;

            if (frameCount >= duration) {
                stop();
            }
        }

        public function stop():void {
            target.alpha = (amount < 0) ? 0 : 1;
            frameCount = 0;
            valid = false;
        }

        public function get Valid():Boolean {
            return valid;
        }

        public function get AnimationName():String {
            return "alphaChanger";
        }

        public function set Target(targetObject:DisplayObject):void {
            if (!target || frameCount == 0) {
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
