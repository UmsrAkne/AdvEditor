package classes.animes {
    import flash.display.DisplayObject;

    public class MaskSlide implements IAnimation {

        private var targetLayerIndex:int = 1;
        private var slide:Slide = new Slide();

        public function MaskSlide() {
        }

        public function execute():void {
            if (!Valid) {
                return;
            }

            slide.execute();
        }

        public function stop():void {
            slide.stop();
        }

        public function get Valid():Boolean {
            return slide.Valid;
        }

        public function get AnimationName():String {
            return "maskSlide";
        }

        public function set Target(targetObject:DisplayObject):void {
            slide.Target = targetObject.parent.mask;
        }

        public function set TargetLayerIndex(index:int):void {
            targetLayerIndex = index;
        }

        public function get TargetLayerIndex():int {
            return targetLayerIndex;
        }

        public function set speed(value:Number):void {
            slide.speed = value;
        }

        public function set degree(value:int):void {
            slide.degree = value;
        }

        public function set distance(value:int):void {
            slide.distance = value;
        }

    }
}
