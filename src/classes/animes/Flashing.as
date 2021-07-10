package classes.animes {
    import flash.display.Bitmap;
    import flash.display.BitmapData;
    import flash.display.DisplayObject;
    import flash.display.DisplayObjectContainer;
    import flash.display.Stage;
    import flash.geom.Rectangle;

    public class Flashing implements IAnimation {

        public var cycle:int = 4;
        public var duration:int = 24;
        public var delay:int;

        private var valid:Boolean = true;
        private var frameCount:int;
        private var target:DisplayObject;
        private var effectBitmap:Bitmap = new Bitmap();
        private var targetLayerIndex:int = 1;
        private var stageRect:Rectangle = new Rectangle();

        public function Flashing() {
        }

        public function set Target(value:DisplayObject):void {
            target = value;
        }

        public function execute():void {
            if (!valid)
                return;

            if (delay > 0) {
                delay--;
                return;
            }

            frameCount++;

            if (frameCount == 1) {
                if (stageRect.equals(new Rectangle())) {
                    var d:Stage = Stage(getTopParent(target));
                    stageRect = new Rectangle(0, 0, d.stageWidth, d.stageHeight);
                }

                var bitmapContainerParent:DisplayObjectContainer = target.parent;
                effectBitmap.bitmapData = new BitmapData(stageRect.width, stageRect.height, false, 0xffffff);
                var targetParent:DisplayObjectContainer = target.parent;
                targetParent.addChildAt(effectBitmap, targetParent.getChildIndex(target) + 1);
                effectBitmap.alpha = 0;
            }

            effectBitmap.alpha = getAlpha(frameCount);

            if (frameCount > duration) {
                stop();
            }
        }

        private function getAlpha(count:int):Number {
            var deg:Number = (180 / cycle * 2 * count) + 270; // + 270　で　Math.sinのグラフを横にずらす
            var rad:Number = deg * Math.PI / 180;

            return (Math.sin(rad) + 1) / 2;
        }

        public function stop():void {
            valid = false;
            frameCount = duration + 1;
            effectBitmap.alpha = 0;
            effectBitmap.visible = false;
            effectBitmap.bitmapData.dispose();

            if (effectBitmap.parent) {
                var childIndex:int = effectBitmap.parent.getChildIndex(effectBitmap);
                effectBitmap.parent.removeChildAt(childIndex);
            }
        }

        public function get TargetLayerIndex():int {
            return targetLayerIndex;
        }

        public function set TargetLayerIndex(value:int):void {
            targetLayerIndex = value;
        }

        public function get Valid():Boolean {
            return valid;
        }

        public function get AnimationName():String {
            return "Flashing";
        }

        public function set TopParentRect(value:Rectangle):void {
            stageRect = value;
        }

        private function getTopParent(displayObject:DisplayObject):DisplayObject {
            while (displayObject.parent) {
                displayObject = displayObject.parent;
            }

            return displayObject;
        }
    }
}
