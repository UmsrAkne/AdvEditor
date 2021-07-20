package classes.contentsLoaders.xmlElements {
    import classes.sceneContents.Scenario;
    import flash.filesystem.File;
    import flash.utils.Dictionary;
    import classes.sceneContents.ImageOrder;
    import flash.events.FileListEvent;
    import classes.contentsLoaders.ContentsLoadUtil;

    public class ImageElementConverter implements IXMLElementConverter {

        public static const A_ATTRIBUTE:String = "@a";
        public static const B_ATTRIBUTE:String = "@b";
        public static const C_ATTRIBUTE:String = "@c";

        public static const TARGET_ATTRIBUTE:String = "@target";

        public static const X_ATTRIBUTE:String = "@x";
        public static const Y_ATTRIBUTE:String = "@y";
        public static const SCALE_ATTRIBUTE:String = "@scale";
        public static const ROTATION_ATTRIBUTE:String = "@rotation";
        public static const BACKGROUND_COLOR_ATTRIBUTE:String = "@backgroundColor";

        public static const STATUS_INHERIT_ATTRIBUTE:String = "@statusInherit";

        private var sceneDirectory:File;
        private var fileList:Vector.<File>;
        private var fileIndexByFileNameDictionary:Dictionary = new Dictionary();

        public function ImageElementConverter(sceneDirectory:File) {
            this.sceneDirectory = sceneDirectory;
        }

        public function get ElementName():String {
            return "image";
        }

        public function convert(scenarioElement:XML, scenario:Scenario):void {
            if (!scenarioElement.hasOwnProperty(ElementName)) {
                return;
            }

            if (fileList == null) {
                FileList = ContentsLoadUtil.getFileList(sceneDirectory.resolvePath("images/").nativePath);
            }

            for each (var imageTag:XML in scenarioElement[ElementName]) {
                var order:ImageOrder = new ImageOrder();
                if (imageTag.hasOwnProperty(A_ATTRIBUTE) || imageTag.hasOwnProperty(B_ATTRIBUTE) || imageTag.hasOwnProperty(C_ATTRIBUTE)) {
                    order.names = new Vector.<String>();

                    var atts:Vector.<String> = new Vector.<String>();
                    atts.push(A_ATTRIBUTE, B_ATTRIBUTE, C_ATTRIBUTE);

                    for each (var att:String in atts) {
                        order.names.push(imageTag[att]);
                        if (imageTag.hasOwnProperty(att)) {

                            // String でキャストしないとオブジェクトキー扱いされるので必須。 
                            order.indexes.push(fileIndexByFileNameDictionary[String(imageTag[att])]);
                        } else {
                            order.indexes.push(0);
                        }
                    }
                }

                if (imageTag.hasOwnProperty(X_ATTRIBUTE) || imageTag.hasOwnProperty(Y_ATTRIBUTE)) {
                    order.x = parseInt(imageTag[X_ATTRIBUTE]);
                    order.y = parseInt(imageTag[Y_ATTRIBUTE]);
                }

                if (imageTag.hasOwnProperty(SCALE_ATTRIBUTE)) {
                    if (!isNaN(parseFloat(imageTag[SCALE_ATTRIBUTE]))) {
                        order.Scale = parseFloat(imageTag[SCALE_ATTRIBUTE]);
                    }
                }

                if (imageTag.hasOwnProperty(ROTATION_ATTRIBUTE)) {
                    if (!isNaN(parseInt(imageTag[ROTATION_ATTRIBUTE]))) {
                        order.rotation = parseInt(imageTag[ROTATION_ATTRIBUTE]);
                    }
                }

                if (imageTag.hasOwnProperty(BACKGROUND_COLOR_ATTRIBUTE)) {
                    if (!isNaN(parseInt(imageTag[BACKGROUND_COLOR_ATTRIBUTE]))) {
                        order.backgroundColor = parseInt(imageTag[BACKGROUND_COLOR_ATTRIBUTE]);
                    }
                }

                if (imageTag.hasOwnProperty(TARGET_ATTRIBUTE)) {
                    order.Target = imageTag[TARGET_ATTRIBUTE];
                }

                if (imageTag.hasOwnProperty(STATUS_INHERIT_ATTRIBUTE)) {
                    if (String(imageTag[STATUS_INHERIT_ATTRIBUTE]) == "true") {
                        order.statusInherit = true;
                    }
                }

                scenario.ImagerOrders.push(order);
            }
        }

        public function set FileList(value:Vector.<File>):void {
            fileList = value;

            for (var i:int = 0; i < fileList.length; i++) {
                var f:File = fileList[i];
                fileIndexByFileNameDictionary[f.name] = i + 1; // 拡張子を含むファイル名全て
                fileIndexByFileNameDictionary[f.name.split(".")[0]] = i + 1; // 拡張子を除いたファイル名
            }
        }
    }
}
