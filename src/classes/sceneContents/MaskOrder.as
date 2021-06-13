package classes.sceneContents {

    import flash.display.Shape;
    import classes.contentsLoaders.xmlElements.TargetAttributeConverter;

    public class MaskOrder {

        public var shape:Shape;
        private var target:String = "main";
        private var targetLayerIndex:int = 1;

        public function MaskOrder() {
        }

        public function set Target(value:String):void {
            targetLayerIndex = TargetAttributeConverter.getLayerIndexFromTargetName(value);
        }

        public function get TargetLayerIndex():int {
            return targetLayerIndex;
        }
    }
}
