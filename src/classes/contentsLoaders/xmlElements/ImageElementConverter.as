package classes.contentsLoaders.xmlElements {
    import classes.sceneContents.Scenario;
    import flash.filesystem.File;

    public class ImageElementConverter implements IXMLElementConverter {

        public static const A_ATTRIBUTE:String = "@a";
        public static const B_ATTRIBUTE:String = "@b";
        public static const C_ATTRIBUTE:String = "@c";

        public static const TARGET_ATTRIBUTE:String = "@target";

        public static const X_ATTRIBUTE:String = "@x";
        public static const Y_ATTRIBUTE:String = "@y";
        public static const SCALE_ATTRIBUTE:String = "@scale";

        private var sceneDirectory:File;

        public function ImageElementConverter(sceneDirectory:File) {
            this.sceneDirectory = sceneDirectory;
        }

        public function get ElementName():String {
            return "image";
        }

        public function convert(scenarioElement:XML, scenario:Scenario):void {
            throw new Error("Method not implemented.");
        }
    }
}
