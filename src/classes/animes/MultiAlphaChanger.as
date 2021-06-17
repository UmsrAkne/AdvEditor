package classes.animes {

    import flash.display.DisplayObject;
    import flash.display.DisplayObjectContainer;

    public class MultiAlphaChanger implements IAnimation {

        private var valid:Boolean = true;
        private var frontTarget:DisplayObject;
        private var backTargets:Vector.<DisplayObject> = new Vector.<DisplayObject>();
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
            var parent:DisplayObjectContainer = targetObject.parent;
            for (var i:int = 0; i < parent.numChildren - 1; i++) {

                // 先頭のディスプレイオブジェクト frontTarget に入力済みなので、ここでは入力しない。
                backTargets.push(parent.getChildAt(i));
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
