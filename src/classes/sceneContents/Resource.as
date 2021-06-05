package classes.sceneContents {

    import flash.display.Loader;
    import flash.utils.Dictionary;
    import flash.geom.Rectangle;
    import flash.display.BitmapData;

    public class Resource {

        public var scenarios:Vector.<Scenario> = new Vector.<Scenario>();

        public var screenSize:Rectangle = new Rectangle(0, 0, 1024, 768);

        private var bitmapDatas:Vector.<BitmapData> = new Vector.<BitmapData>();
        private var bitmapDatasByName:Dictionary = new Dictionary();

        public function get BitmapDatas():Vector.<BitmapData> {
            return bitmapDatas;
        }

        public function get BitmapDatasByName():Dictionary {
            return bitmapDatasByName;
        }
    }
}
