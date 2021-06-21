package classes.uis {

    import flash.media.SoundChannel;
    import flash.media.SoundTransform;

    public class SoundChannelWrapper {

        private var soundChannel:SoundChannel;

        public function SoundChannelWrapper() {
        }

        public function setSoundChannel(channel:SoundChannel):void {
            soundChannel = channel;
        }

        public function stop():void {
            if (soundChannel != null) {
                soundChannel.stop();
            }
        }
    }
}
