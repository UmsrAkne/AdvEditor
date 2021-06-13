package classes.contentsLoaders {

    import classes.sceneContents.Resource;
    import flash.events.EventDispatcher;
    import flash.filesystem.File;
    import flash.net.URLLoader;
    import flash.events.Event;
    import flash.net.URLRequest;

    public class SettingLoader implements ILoader {

        private var completeEventDispatcher:EventDispatcher = new EventDispatcher();
        private var sceneDirectory:File;
        private var settingXMLList:XMLList;

        public static const ELEMENT_NAME:String = "setting";
        public static const WIDTH_ATTRIBUTE:String = "@width";
        public static const HEIGHT_ATTRIBUTE:String = "@height"
        public static const X_ATTRIBUTE:String = "@x";
        public static const Y_ATTRIBUTE:String = "@y"

        public function SettingLoader(sceneDirectory:File) {
            this.sceneDirectory = sceneDirectory;
        }

        public function writeContentsTo(resource:Resource):void {
            if (!settingXMLList.hasOwnProperty(ELEMENT_NAME)) {
                return;
            }

            var xml:XML = settingXMLList[ELEMENT_NAME][0];

            if (xml.hasOwnProperty(WIDTH_ATTRIBUTE)) {
                resource.ScreenSize.width = parseInt(xml[WIDTH_ATTRIBUTE]);
            }

            if (xml.hasOwnProperty(HEIGHT_ATTRIBUTE)) {
                resource.ScreenSize.height = parseInt(xml[HEIGHT_ATTRIBUTE]);
            }

            if (xml.hasOwnProperty(X_ATTRIBUTE)) {
                resource.ScreenSize.x = parseInt(xml[X_ATTRIBUTE]);
            }

            if (xml.hasOwnProperty(Y_ATTRIBUTE)) {
                resource.ScreenSize.y = parseInt(xml[Y_ATTRIBUTE]);
            }
        }

        public function load():void {
            var urlLoader:URLLoader = new URLLoader();
            urlLoader.addEventListener(Event.COMPLETE, function(e:Event):void {
                settingXMLList = new XMLList(URLLoader(e.target).data);
                completeEventDispatcher.dispatchEvent(new Event(Event.COMPLETE));
            });

            urlLoader.load(new URLRequest(sceneDirectory.resolvePath("texts/setting.xml").nativePath));
        }

        public function get CompleteEventDispatcher():EventDispatcher {
            return completeEventDispatcher;
        }

        /**
         * テスト用プロパティ。ターゲットが null の場合にのみセット可能。
         * @param value
         */
        public function set SettingXML(value:XMLList):void {
            if (!settingXMLList) {
                settingXMLList = value;
            }
        }
    }
}