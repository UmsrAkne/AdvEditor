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

        /**
         * @return 左右の音声の振幅を足して２で割った値(0-1.0)を返します。SoundChannel がセットされていない場合は 0 を返します。
         */
        public function getPeak():Number {
            return (soundChannel == null) ? 0 : (soundChannel.leftPeak + soundChannel.rightPeak) / 2;
        }

        public function stop():void {
            if (soundChannel != null) {
                soundChannel.stop();
            }
        }
    }
}
