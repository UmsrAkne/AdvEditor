package classes.sceneContents {

    import flash.display.Loader;
    import flash.utils.Dictionary;
    import flash.geom.Rectangle;
    import flash.display.BitmapData;

    public class Resource {

        public var scenarios:Vector.<Scenario> = new Vector.<Scenario>();

        private var screenSize:Rectangle = new Rectangle(0, 0, 1024, 768);

        private var bitmapDatas:Vector.<BitmapData> = new Vector.<BitmapData>();
        private var bitmapDatasByName:Dictionary = new Dictionary();

        private var blinkOrdersByName:Dictionary = new Dictionary();
        private var lipOrdersByName:Dictionary = new Dictionary();

        private var voices:Vector.<SoundFile> = new Vector.<SoundFile>();
        private var bgvs:Vector.<SoundFile> = new Vector.<SoundFile>();
        private var bgms:Vector.<SoundFile> = new Vector.<SoundFile>();
        private var ses:Vector.<SoundFile> = new Vector.<SoundFile>();

        public function get ScreenSize():Rectangle {
            return screenSize;
        }

        public function get BitmapDatas():Vector.<BitmapData> {
            return bitmapDatas;
        }

        public function get BitmapDatasByName():Dictionary {
            return bitmapDatasByName;
        }

        public function get BlinkOrdersByName():Dictionary {
            return blinkOrdersByName;
        }

        public function get LipOrdersByName():Dictionary {
            return lipOrdersByName;
        }

        public function get Voices():Vector.<SoundFile> {
            return voices;
        }

        public function get BGVs():Object {
            return bgvs;
        }

        public function get BGMs():Vector.<SoundFile> {
            return bgms;
        }

        public function get SEs():Vector.<SoundFile> {
            return ses;
        }
    }
}
