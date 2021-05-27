package classes.sceneContents {

    import flash.filesystem.File;
    import flash.media.Sound;
    import flash.net.URLRequest;

    public class SoundFile {

        private var file:File;
        private var sound:ISound;

        public function SoundFile(file:File, sound:ISound = null) {
            this.file = file;
            this.sound = sound;
        }

        public function getSound():ISound {
            if (sound == null) {
                sound = new ExSound(new Sound(new URLRequest(file.nativePath)));
            }

            return sound;
        }
    }
}
