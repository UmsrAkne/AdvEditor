package classes.sceneContents {

    import flash.display.Loader;
    import flash.utils.Dictionary;
    import flash.geom.Rectangle;
    import flash.display.BitmapData;
    import classes.uis.UIImages;
    import flash.filesystem.File;

    public class Resource {

        public var sceneDirectory:File;
        public var scenarios:Vector.<Scenario> = new Vector.<Scenario>();
        private var scenariosByChapterName:Dictionary = new Dictionary();
        private var chapterHeaderIndexByChapterName:Dictionary = new Dictionary();

        public var voiceVolume:Number = 1.0;
        public var backVoiceVolume:Number = 1.0;
        public var seVolume:Number = 1.0;
        public var bgmVolume:Number = 1.0;

        public var defaultScale:Number = 1.0;

        private var screenSize:Rectangle = new Rectangle(0, 0, 1024, 768);

        private var bitmapDatas:Vector.<BitmapData> = new Vector.<BitmapData>();
        private var bitmapDatasByName:Dictionary = new Dictionary();

        private var uiImages:UIImages = new UIImages();

        private var blinkOrdersByName:Dictionary = new Dictionary();
        private var lipOrdersByName:Dictionary = new Dictionary();

        private var voices:Vector.<SoundFile> = new Vector.<SoundFile>();

        private var bgvs:Vector.<SoundFile> = new Vector.<SoundFile>();
        private var bgvsByName:Dictionary = new Dictionary();

        private var bgms:Vector.<SoundFile> = new Vector.<SoundFile>();
        private var bgmsByName:Dictionary = new Dictionary();
        private var initialBGMName:String;

        private var ses:Vector.<SoundFile> = new Vector.<SoundFile>();

        public function get ScenariosByChapterName():Dictionary {
            return scenariosByChapterName;
        }

        public function get ChapterHeaderIndexByChapterName():Dictionary {
            return chapterHeaderIndexByChapterName;
        }

        public function get ScreenSize():Rectangle {
            return screenSize;
        }

        public function get BitmapDatas():Vector.<BitmapData> {
            return bitmapDatas;
        }

        public function get BitmapDatasByName():Dictionary {
            return bitmapDatasByName;
        }

        public function get UIImageContainer():UIImages {
            return uiImages;
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

        public function get BGVs():Vector.<SoundFile> {
            return bgvs;
        }

        public function get BGVsByName():Dictionary {
            return bgvsByName;
        }

        public function get BGMs():Vector.<SoundFile> {
            return bgms;
        }

        public function get BGMsByName():Dictionary {
            return bgmsByName;
        }

        public function get InitialBGMName():String {
            return initialBGMName;
        }

        public function set InitialBGMName(value:String):void {
            initialBGMName = value;
        }

        public function get SEs():Vector.<SoundFile> {
            return ses;
        }
    }
}
