package classes.sceneContents {

    import classes.contentsLoaders.xmlElements.TargetAttributeConverter;

    /** シーン中に書き込む画像の詳細なデータを保持するクラスです。 */
    public class ImageOrder {

        public var names:Vector.<String> = new Vector.<String>();
        public var indexes:Vector.<int> = new Vector.<int>();
        public var targetLayerIndex:int = 1;

        public var x:int = 0;
        public var y:int = 0;
        public var rotation:int = 0;
        public var delay:int;

        public var backgroundColor:uint = 0x00000000;
        public var drawingDepth:Number = 0.1;
        public var statusInherit:Boolean;

        private var scale:Number = 1.0;
        private var scaleIsDefault:Boolean = true;
        private var target:String = "main";

        public function ImageOrder() {
        }

        public function set Target(value:String):void {
            target = value;
            targetLayerIndex = TargetAttributeConverter.getLayerIndexFromTargetName(target);
        }

        public function set Scale(value:Number):void {
            scale = value;
            scaleIsDefault = false;
        }

        public function get Scale():Number {
            return scale;
        }

        public function get ScaleIsDefault():Boolean {
            return scaleIsDefault;
        }
    }
}
