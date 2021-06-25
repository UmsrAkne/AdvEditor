package classes.sceneContents {

    public class BGVOrder {

        private var indexes:Vector.<int> = new Vector.<int>;
        private var names:Vector.<String> = new Vector.<String>;
        private var characterChannel:int;

        public function get Indexes():Vector.<int> {
            return indexes;
        }

        public function get Names():Vector.<String> {
            return names;
        }

        public function get CharacterChannel():int {
            return characterChannel;
        }

        public function set CharacterChannel(value:int):void {
            characterChannel = value;
        }
    }
}
