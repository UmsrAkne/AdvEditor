package classes.sceneContents {

    public class BlinkOrder {

        private var baseImageName:String = "";
        private var closeImageName:String = "";
        private var openImageNames:Vector.<String> = new Vector.<String>();

        public function BlinkOrder() {
        }

        public function get BaseImageName():String {
            return baseImageName;
        }

        public function set BaseImageName(value:String):void {
            baseImageName = value;
        }

        public function get CloseImageName():String {
            return closeImageName;
        }

        public function set CloseImageName(value:String):void {
            closeImageName = value;
        }

        public function get OpenImageNames():Vector.<String> {
            return openImageNames;
        }

        public function buildOrder():Vector.<String> {
            var v:Vector.<String>;
            v = OpenImageNames.concat().reverse();
            v.push(closeImageName);
            return v.concat(OpenImageNames);
        }
    }
}
