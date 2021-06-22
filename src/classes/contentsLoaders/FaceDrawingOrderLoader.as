package classes.contentsLoaders {

    import flash.filesystem.File;
    import flash.events.EventDispatcher;
    import flash.net.URLLoader;
    import flash.events.Event;
    import flash.net.URLRequest;
    import classes.sceneContents.Resource;
    import classes.sceneContents.BlinkOrder;
    import classes.sceneContents.LipOrder;

    public class FaceDrawingOrderLoader implements ILoader {

        private var completeEventDispatcher:EventDispatcher = new EventDispatcher();
        private var sceneDirectory:File;
        private var orderXMLList:XMLList;

        public static const BLINK_ORDERS_ELEMENT_NAME:String = "blinkOrders";
        public static const LIP_ORDERS_ELEMENT_NAME:String = "lipOrders";
        public static const ORDER_ELEMENT_NAME:String = "order"
        public static const BASE_ATTRIBUTE:String = "@base";
        public static const OPEN_ATTRIBUTE:String = "@open";
        public static const CLOSE_ATTRIBUTE:String = "@close";

        public function FaceDrawingOrderLoader(sceneDirectory:File) {
            this.sceneDirectory = sceneDirectory;
        }

        public function writeContentsTo(resource:Resource):void {
            var xml:XML;

            if (orderXMLList.hasOwnProperty(BLINK_ORDERS_ELEMENT_NAME)) {
                // blink のロード処理
                xml = orderXMLList[BLINK_ORDERS_ELEMENT_NAME][0];
                for each (var orderTag:XML in xml[ORDER_ELEMENT_NAME]) {
                    var blinkOrder:BlinkOrder = new BlinkOrder();
                    blinkOrder.BaseImageName = orderTag[BASE_ATTRIBUTE];
                    blinkOrder.CloseImageName = orderTag[CLOSE_ATTRIBUTE];

                    var openImageNames:Array = String(orderTag[OPEN_ATTRIBUTE]).split(",");
                    for each (var openImageName:String in openImageNames) {
                        blinkOrder.OpenImageNames.push(openImageName);
                    }

                    resource.BlinkOrdersByName[blinkOrder.BaseImageName] = blinkOrder;
                }
            }

            if (orderXMLList.hasOwnProperty(LIP_ORDERS_ELEMENT_NAME)) {
                // lip のロード処理
                xml = orderXMLList[LIP_ORDERS_ELEMENT_NAME][0];
                for each (var lipOrderTag:XML in xml[ORDER_ELEMENT_NAME]) {
                    var lipOrder:LipOrder = new LipOrder();
                    lipOrder.BaseImageName = lipOrderTag[BASE_ATTRIBUTE];
                    lipOrder.CloseImageName = lipOrderTag[CLOSE_ATTRIBUTE];

                    var lipOpenImageNames:Array = String(lipOrderTag[OPEN_ATTRIBUTE]).split(",");
                    for each (var lipOpenImageName:String in lipOpenImageNames) {
                        lipOrder.OpenImageNames.push(lipOpenImageName);
                    }

                    resource.LipOrdersByName[lipOrder.BaseImageName] = lipOrder;
                }
            }
        }

        public function load():void {
            var urlloader:URLLoader = new URLLoader();
            urlloader.addEventListener(Event.COMPLETE, function(e:Event):void {
                orderXMLList = new XMLList(URLLoader(e.target).data);
                completeEventDispatcher.dispatchEvent(new Event(Event.COMPLETE));
            });

            urlloader.load(new URLRequest(sceneDirectory.resolvePath("texts/faceDrawingOrder.xml").nativePath));
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
