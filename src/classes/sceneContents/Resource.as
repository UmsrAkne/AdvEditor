package classes.sceneContents {

    import flash.display.Loader;
    import flash.utils.Dictionary;
    import flash.geom.Rectangle;

    public class Resource {

        public var scenarios:Vector.<Scenario> = new Vector.<Scenario>();
        public var imageLoaders:Vector.<Loader> = new Vector.<Loader>();
        public var imageLoadersByName:Dictionary = new Dictionary();
        public var screenSize:Rectangle = new Rectangle(0, 0, 1024, 768);

        public function Resource() {
        }
    }
}
