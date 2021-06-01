package classes.contentsLoaders.xmlElements {
    import classes.sceneContents.Scenario;
    import flash.filesystem.File;
    import flash.utils.Dictionary;
    import classes.sceneContents.ImageOrder;

    public class ImageElementConverter implements IXMLElementConverter {

        public static const A_ATTRIBUTE:String = "@a";
        public static const B_ATTRIBUTE:String = "@b";
        public static const C_ATTRIBUTE:String = "@c";

        public static const TARGET_ATTRIBUTE:String = "@target";

        public static const X_ATTRIBUTE:String = "@x";
        public static const Y_ATTRIBUTE:String = "@y";
        public static const SCALE_ATTRIBUTE:String = "@scale";

        private var sceneDirectory:File;
        private var fileList:Vector.<File>;
        private var fileByFileNameDictionary:Dictionary = new Dictionary();

        public function ImageElementConverter(sceneDirectory:File) {
            this.sceneDirectory = sceneDirectory;
        }

        public function get ElementName():String {
            return "image";
        }

        /**
         * テスト用メソッド
         * @param value
         */
        public function set FileList(value:Vector.<File>):void {
            if (fileList == null) {
                fileList = value;

                for each (var f:File in fileList) {
                    fileByFileNameDictionary[f.name] = f;
                    fileByFileNameDictionary[f.name.split(".")[0]] = f;
                }
            }
        }

        public function convert(scenarioElement:XML, scenario:Scenario):void {
            if (!scenarioElement.hasOwnProperty(ElementName)) {
                return;
            }

            for each (var imageTag:XML in scenarioElement[ElementName]) {
                var order:ImageOrder = new ImageOrder();
                if (imageTag.hasOwnProperty(A_ATTRIBUTE) || imageTag.hasOwnProperty(B_ATTRIBUTE) || imageTag.hasOwnProperty(C_ATTRIBUTE)) {
                    order.names = new Vector.<String>();
                    order.names.push(imageTag[A_ATTRIBUTE]);
                    order.names.push(imageTag[B_ATTRIBUTE]);
                    order.names.push(imageTag[C_ATTRIBUTE]);
                }

                if (imageTag.hasOwnProperty(X_ATTRIBUTE) || imageTag.hasOwnProperty(Y_ATTRIBUTE)) {
                    order.x = parseInt(imageTag[X_ATTRIBUTE]);
                    order.y = parseInt(imageTag[Y_ATTRIBUTE]);
                }

                if (imageTag.hasOwnProperty(SCALE_ATTRIBUTE)) {
                    if (!isNaN(parseFloat(imageTag[SCALE_ATTRIBUTE]))) {
                        order.scale = parseFloat(imageTag[SCALE_ATTRIBUTE]);
                    }
                }

                if (imageTag.hasOwnProperty(TARGET_ATTRIBUTE)) {
                    order.Target = imageTag[TARGET_ATTRIBUTE];
                }

                scenario.ImagerOrders.push(order);
            }
        }

        /**
         *  最初は private function get FileList() で宣言してが、エラーの表示が無いにも関わらずビルドに失敗するので getter ライクな命名で。
         *  ActionScript3.0 のバグか？
         * @return
         */
        private function getFileList():Vector.<File> {
            if (fileList != null) {
                return fileList;
            }

            var fileVec:Vector.<File> = new Vector.<File>();
            var files:Array = sceneDirectory.resolvePath("/images").getDirectoryListing();
            for (var i:int = 0; i < files.length; i++) {
                fileVec.push(files[i]);
            }

            FileList = fileVec;

            return fileList;
        }
    }
}
