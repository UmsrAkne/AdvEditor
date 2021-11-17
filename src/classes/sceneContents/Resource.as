package classes.sceneContents {

    import classes.uis.UIImages;
    import flash.display.BitmapData;
    import flash.filesystem.File;
    import flash.geom.Rectangle;
    import flash.utils.Dictionary;

    public class Resource {

        public var sceneDirectory:File;
        public var scenarios:Vector.<Scenario> = new Vector.<Scenario>();

        private var useAnimators:Vector.<Boolean> = new <Boolean>[false, false, false, false];

        private var scenariosByChapterName:Dictionary = new Dictionary();
        private var chapterHeaderIndexByChapterName:Dictionary = new Dictionary();

        public var voiceVolume:Number = 1.0;
        public var backVoiceVolume:Number = 1.0;
        public var seVolume:Number = 1.0;
        public var bgmVolume:Number = 1.0;

        public var defaultScale:Number = 1.0;

        private var screenSize:Rectangle = new Rectangle(0, 0, 1024, 768);

        private var imageFiles:Vector.<ImageFile> = new Vector.<ImageFile>();
        private var imageFilesByName:Dictionary = new Dictionary();

        private var imageDrawingPointByName:Dictionary = new Dictionary();

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

        public function dispose():void {
            var imageFile:ImageFile;
            for each (imageFile in imageFiles) {
                if (imageFile.getBitmapData() != null) {
                    imageFile.getBitmapData().dispose();
                }
            }

            for each (imageFile in imageFilesByName) {
                if (imageFile.getBitmapData() != null) {
                    imageFile.getBitmapData().dispose();
                }
            }

            for (var i:int = 0; i < scenarios.length; i++) {
                scenarios[i] = null;
            }

            scenarios = null;
        }

        public function get ScenariosByChapterName():Dictionary {
            return scenariosByChapterName;
        }

        public function get ChapterHeaderIndexByChapterName():Dictionary {
            return chapterHeaderIndexByChapterName;
        }

        public function get ScreenSize():Rectangle {
            return screenSize;
        }

        public function get ImageFiles():Vector.<ImageFile> {
            return imageFiles;
        }

        public function get ImageFilesByName():Dictionary {
            return imageFilesByName;
        }

        public function get UIImageContainer():UIImages {
            return uiImages;
        }

        public function get ImageDrawingPointByName():Dictionary {
            return imageDrawingPointByName;
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

        public function get UseAnimators():Vector.<Boolean> {
            return useAnimators;
        }
    }
}
