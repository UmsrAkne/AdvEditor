package classes.sceneContents {

    public class LipOrder {
        private var baseImageName:String;
        private var closeImageName:String;
        private var openImageNames:Vector.<String> = new Vector.<String>();
        private var order:Vector.<String>;

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
            order = OpenImageNames.concat().reverse();
            order.push(closeImageName);
            return order.concat(OpenImageNames);
        }

        public function getOrder():Vector.<String> {
            if (order == null) {
                return buildOrder();
            }

            return order;
        }
    }
}
