package classes.sceneContents {

    import flash.filesystem.File;
    import flash.media.Sound;
    import flash.net.URLRequest;

    public class SoundFile {

        private var file:File;
        private var fileName:String;
        private var sound:ISound;
        private var index:int = -1;
        private var volume:Number = 1.0;
        private var characterChannel:int;
        private var volumeIsDefault:Boolean = true;
        private var _delay:int;

        public function SoundFile(file:File = null, sound:ISound = null) {
            this.file = file;
            this.sound = sound;
        }

        public function set FileName(value:String):void {
            fileName = value;
        }

        public function get FileName():String {
            return file.name;
        }

        public function set Index(value:int):void {
            index = value;
        }

        public function get Index():int {
            return index;
        }

        public function get Volume():Number {
            return volume;
        }

        public function set Volume(value:Number):void {
            volume = value;
            volumeIsDefault = false;
        }

        public function getSound():ISound {
            if (sound == null) {
                if (file.extension == null) {
                    sound = new ExSound(new Sound(new URLRequest(file.nativePath + ".mp3")));
                } else {
                    sound = new ExSound(new Sound(new URLRequest(file.nativePath)));
                }
            }

            return sound;
        }

        public function get CharacterChannel():int {
            return characterChannel;
        }

        public function set CharacterChannel(value:int):void {
            characterChannel = value;
        }

        public function get delay():int {
            return _delay;
        }

        public function set delay(value:int):void {
            _delay = value;
        }

        /**
         * ????????????????????????????????? Volume ????????????????????????????????????????????????????????????
         * ?????? ???????????? set Volume ??????????????????????????????????????? false ??????????????????
         * set ??????????????????????????????????????????????????????
         * @return
         */
        public function get VolumeIsDefault():Boolean {
            return volumeIsDefault;
        }
    }
}
