package classes.uis {

    import flash.media.SoundChannel;
    import flash.media.SoundTransform;
    import flash.events.EventDispatcher;
    import flash.events.Event;

    public class SoundChannelWrapper extends EventDispatcher {

        public static const SOUND_CHANNEL_REPLACED:String = "soundChannelReplaced";

        private var soundChannel:SoundChannel;
        private var volume:Number = 1.0;

        public function SoundChannelWrapper() {
        }

        public function setSoundChannel(channel:SoundChannel):void {
            if (soundChannel != null) {
                soundChannel.removeEventListener(Event.SOUND_COMPLETE, dispatchCompleteEvent);
            }

            soundChannel = channel;
            soundChannel.addEventListener(Event.SOUND_COMPLETE, dispatchCompleteEvent);
            dispatchEvent(new Event(SOUND_CHANNEL_REPLACED));
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
                dispatchEvent(new Event(Event.SOUND_COMPLETE));
            }
        }

        public function set Volume(value:Number):void {
            volume = value;

            if (soundChannel != null) {
                var t:SoundTransform = new SoundTransform();
                t.volume = volume;
                soundChannel.soundTransform = t;
            }
        }

        private function dispatchCompleteEvent(e:Event):void {
            dispatchEvent(e);
        }
    }
}
