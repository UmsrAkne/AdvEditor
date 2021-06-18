package classes.animes {

    import flash.display.DisplayObject;
    import flash.display.DisplayObjectContainer;

    public class MultiAlphaChanger implements IAnimation {

        /**
         * 最前面のディスプレイオブジェクトに適用する alpha の値です。
         */
        public var front:Number = 0.1;

        /**
         * 最前面のディスプレイオブジェクト以外に適用する alpha の値です。
         */
        public var backs:Number = -0.1;

        private var valid:Boolean = true;
        private var frontTarget:DisplayObject;
        private var backTargets:Vector.<DisplayObject> = new Vector.<DisplayObject>();
        private var targetLayerIndex:int;

        private var alphaChangers:Vector.<AlphaChanger> = new Vector.<AlphaChanger>();

        public function MultiAlphaChanger() {
        }

        public function execute():void {
            if (!valid) {
                return;
            }

            for each (var a:AlphaChanger in alphaChangers) {
                a.execute();
            }

            var existValidAnimation:Boolean = alphaChangers.some(function(item:AlphaChanger, idx:int, v:Vector.<AlphaChanger>):Boolean {
                return item.Valid;
            });

            if (!existValidAnimation) {
                stop();
            }
        }

        public function stop():void {
            valid = false;
            for each (var alphaChanger:AlphaChanger in alphaChangers) {
                alphaChanger.stop();
            }
        }

        public function get Valid():Boolean {
            return valid;
        }

        public function get AnimationName():String {
            return "alphaChanger";
        }

        public function set Target(targetObject:DisplayObject):void {
            if (frontTarget != null) {
                return;
            }

            frontTarget = targetObject;
            alphaChangers.push(new AlphaChanger());
            var parent:DisplayObjectContainer = targetObject.parent;
            for (var i:int = 0; i < parent.numChildren - 1; i++) {

                // 先頭のディスプレイオブジェクト frontTarget に入力済みなので、ここでは入力しない。
                backTargets.push(parent.getChildAt(i));
            }

            alphaChangers[0].Target = frontTarget;
            alphaChangers[0].amount = front;

            for each (var t:DisplayObject in backTargets) {
                var a:AlphaChanger = new AlphaChanger();
                a.amount = backs;
                a.Target = t;
                alphaChangers.push(a);
            }
        }

        public function set TargetLayerIndex(index:int):void {
            targetLayerIndex = index;
        }

        public function get TargetLayerIndex():int {
            return targetLayerIndex;
        }

        public function set strength(value:Number):void {
            front = value;
            backs = value * -1;
        }
    }
}
