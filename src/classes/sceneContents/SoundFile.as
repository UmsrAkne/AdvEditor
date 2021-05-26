package classes.sceneContents {

    import flash.filesystem.File;
    import flash.media.Sound;
    import flash.net.URLRequest;

    public class SoundFile {

        private var file:File;
        private var sound:Sound;

        public function SoundFile(file:File) {
            this.file = file;
        }

        public function getSound():Sound {
            if (sound == null) {
                sound = new Sound(new URLRequest(file.nativePath));
            }

            return sound;
        }
    }
}
