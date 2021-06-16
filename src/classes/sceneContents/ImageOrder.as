package classes.sceneContents {

    import classes.contentsLoaders.xmlElements.TargetAttributeConverter;

    /** シーン中に書き込む画像の詳細なデータを保持するクラスです。 */
    public class ImageOrder {

        public var names:Vector.<String> = new Vector.<String>();
        public var indexes:Vector.<int> = new Vector.<int>();
        public var targetLayerIndex:int = 1;

        public var x:int = 0;
        public var y:int = 0;
        public var scale:Number = 1.0;
        public var rotation:int = 0;

        public var drawingDepth:Number = 1.0;
        public var statusInherit:Boolean;

        private var target:String = "main";

        public function ImageOrder() {
        }

        public function set Target(value:String):void {
            target = value;
            targetLayerIndex = TargetAttributeConverter.getLayerIndexFromTargetName(target);
        }
    }
}
