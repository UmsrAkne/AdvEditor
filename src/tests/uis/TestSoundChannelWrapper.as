package tests.uis {

    import flash.media.SoundChannel;
    import classes.uis.SoundChannelWrapper;

    public class TestSoundChannelWrapper {
        public function TestSoundChannelWrapper() {
            testVolume();
        }

        private function testVolume():void {
            var scw:SoundChannelWrapper = new SoundChannelWrapper();
            var channel:SoundChannel = new SoundChannel();
            scw.setSoundChannel(channel);
            scw.Volume = 0.5;
        }
    }
}
