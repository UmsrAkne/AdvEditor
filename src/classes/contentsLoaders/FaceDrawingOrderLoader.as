package classes.contentsLoaders {

    import flash.filesystem.File;
    import flash.events.EventDispatcher;
    import flash.net.URLLoader;
    import flash.events.Event;
    import flash.net.URLRequest;
    import classes.sceneContents.Resource;

    public class FaceDrawingOrderLoader {

        private var completeEventDispatcher:EventDispatcher = new EventDispatcher();
        private var sceneDirectory:File;
        private var orderXMLList:XMLList;

        public static const BLINK_ORDER_ELEMENT_NAME:String = "blinkOrders";
        public static const LIP_ORDER_ELEMENT_NAME:String = "lipOrders";
        public static const BASE_IMAGE_NAME_ATTRIBUTE:String = "@baseImageName";
        public static const OPEN_IMAGE_NAMES_ATTRIBUTE:String = "@openImageNames";
        public static const CLOSE_IMAGE_NAME_ATTRIBUTE:String = "@closeImageName";

        public function FaceDrawingOrderLoader(sceneDirectory:File) {
            this.sceneDirectory = sceneDirectory;
        }

        public function writeContentsTo(resource:Resource):void {
            var xml:XML;

            if (orderXMLList.hasOwnProperty(BLINK_ORDER_ELEMENT_NAME)) {
                // blink のロード処理
                xml = orderXMLList[BLINK_ORDER_ELEMENT_NAME][0];
            }

            if (orderXMLList.hasOwnProperty(LIP_ORDER_ELEMENT_NAME)) {
                // lip のロード処理
                xml = orderXMLList[LIP_ORDER_ELEMENT_NAME][0];
            }
        }

        public function load():void {
            var urlLoader:URLLoader = new URLLoader();
            urlLoader.addEventListener(Event.COMPLETE, function(e:Event):void {
                orderXMLList = new XMLList(URLLoader(e.target).data);
                completeEventDispatcher.dispatchEvent(new Event(Event.COMPLETE));
            });

            urlLoader.load(new URLRequest(sceneDirectory.resolvePath("texts/faceDrawingOrder.xml").nativePath));
        }

        public function get CompleteEventDispatcher():EventDispatcher {
            return completeEventDispatcher;
        }

        /**
         * テスト用プロパティ。ターゲットが null の場合にのみセット可能。
         * @param value
         */
        public function set OrderXMLList(value:XMLList):void {
            if (!orderXMLList) {
                orderXMLList = value;
            }
        }

    }
}
