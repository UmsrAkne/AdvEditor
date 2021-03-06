package classes.sceneContents {

    public class BGVOrder {

        private var indexes:Vector.<int> = new Vector.<int>;
        private var names:Vector.<String> = new Vector.<String>;
        private var volume:Number = 1.0;
        private var characterChannel:int;
        private var volumeIsDefault:Boolean = true;

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

        public function get Volume():Number {
            return volume;
        }

        public function set Volume(value:Number):void {
            volume = value;
            volumeIsDefault = false;
        }

        public function get VolumeIsDefault():Boolean {
            return volumeIsDefault;
        }
    }
}
