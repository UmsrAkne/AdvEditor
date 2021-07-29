package classes.animes {

    import flash.display.DisplayObject;
    import flash.geom.Rectangle;

    public class LoopSlide implements IAnimation {

        public var interval:int;

        private var intervalCounter:int;
        private var target:DisplayObject;
        private var targetLayerIndex:int = 1;
        private var valid:Boolean = true;
        private var deg:int;
        private var spd:Number = 1.0;
        private var slide:Slide;

        public function LoopSlide() {
        }

        public function execute():void {
            if (intervalCounter > 0) {
                intervalCounter--;
                return;
            }

            if (!slide) {
                slide = new Slide();
                slide.Target = target;
                slide.degree = deg;
                slide.speed = spd;
            }

            slide.execute();

            if (!slide.Valid) {
                slide = null;
                intervalCounter = interval;
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
            target = targetObject;
        }

        public function set TargetLayerIndex(index:int):void {
            targetLayerIndex = index;
        }

        public function get TargetLayerIndex():int {
            return targetLayerIndex;
        }

        public function set degree(value:int):void {
            deg = value;
        }

        public function set speed(value:Number):void {
            spd = value;
        }
    }
}
