package classes.animes {

    import flash.display.DisplayObject;
    import flash.geom.Point;
    import flash.geom.Rectangle;

    public class ScaleChanger implements IAnimation {

        public var strength:Number = 0.1;
        public var delay:int
        public var total:Number = 0;

        private var target:DisplayObject;
        private var valid:Boolean = true;
        private var totalChanged:Number = 0;
        private var less:Number = 1.0;
        private var frameCount:int;
        private var targetLayerIndex:int = 1;

        public function set Target(value:DisplayObject):void {
            if (!target) {
                target = value;
            }
        }

        public function execute():void {
            if (!valid) {
                stop();
            }

            frameCount++;

            if (frameCount < delay) {
                return;
            }

            if (totalChanged > total * 0.8) {
                // 現在の値が目標値の８割を超えたら除算の分母の値を加算し始める。
                // これでアニメーション後半でブレーキをかける。
                less += 0.25;
            }

            // target のサイズと拡縮の変化量から、画面の中心を基準にして拡大する。
            var actualStrength:Number = strength / less;
            var originalTargetSize:Rectangle = new Rectangle(0, 0, target.width / target.scaleX, target.height / target.scaleY);
            var fixPos:Point = new Point(originalTargetSize.width * actualStrength / 2, originalTargetSize.height * actualStrength / 2);
            target.scaleX += actualStrength;
            target.scaleY += actualStrength;
            totalChanged += Math.abs(actualStrength);
            target.x -= fixPos.x;
            target.y -= fixPos.y;

            if (totalChanged >= total) {
                valid = false;
                stop();
            }
        }

        public function stop():void {
            valid = false;
        }

        public function get TargetLayerIndex():int {
            return targetLayerIndex
        }

        public function set TargetLayerIndex(value:int):void {
            targetLayerIndex = value;
        }

        public function get Valid():Boolean {
            return valid;
        }

        public function get AnimationName():String {
            return "scaleChanger"
        }
    }
}
