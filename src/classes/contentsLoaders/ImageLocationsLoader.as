package classes.contentsLoaders {

    import classes.sceneContents.Resource;
    import flash.desktop.NativeApplication;
    import flash.events.Event;
    import flash.events.EventDispatcher;
    import flash.filesystem.File;
    import flash.net.URLLoader;
    import flash.net.URLRequest;
    import flash.geom.Point;

    public class ImageLocationsLoader implements ILoader {

        private var completeEventDispatcher:EventDispatcher = new EventDispatcher();

        private var sceneDirectory:File;
        private var locationXMLList:XMLList = new XMLList();

        public static const ELEMENT_NAME:String = "location";
        public static const NAME_ATTRIBUTE:String = "@name";
        public static const X_ATTRIBUTE:String = "@x";
        public static const Y_ATTRIBUTE:String = "@y";

        public function ImageLocationsLoader(sceneDirectory:File) {
            this.sceneDirectory = sceneDirectory;
        }

        public function writeContentsTo(resource:Resource):void {
            for each (var locationTag:XML in locationXMLList[ELEMENT_NAME]) {
                var p:Point = new Point();
                if (locationTag.hasOwnProperty(X_ATTRIBUTE)) {
                    p.x = parseInt(locationTag[X_ATTRIBUTE]);
                }

                if (locationTag.hasOwnProperty(Y_ATTRIBUTE)) {
                    p.y = parseInt(locationTag[Y_ATTRIBUTE]);
                }

                resource.ImageDrawingPointByName[String(locationTag[NAME_ATTRIBUTE])] = p;
            }
        }

        public function load():void {
            var urlLoader:URLLoader = new URLLoader();
            urlLoader.addEventListener(Event.COMPLETE, function(e:Event):void {
                try {
                    locationXMLList = new XMLList(URLLoader(e.target).data);
                } catch (error:TypeError) {
                    trace(error.message);
                    NativeApplication.nativeApplication.exit();
                    return;
                }

                completeEventDispatcher.dispatchEvent(new Event(Event.COMPLETE));
            });

            urlLoader.load(new URLRequest(sceneDirectory.resolvePath("texts/imageLocations.xml").nativePath));
        }

        public function set LocationXMLList(xmlList:XMLList):void {
            locationXMLList = xmlList;
        }

        public function get CompleteEventDispatcher():EventDispatcher {
            return completeEventDispatcher;
        }
    }
}
