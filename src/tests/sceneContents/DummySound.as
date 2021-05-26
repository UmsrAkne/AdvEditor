package tests.sceneContents {
    import classes.sceneContents.ISound;
    import flash.events.Event;
    import flash.media.SoundTransform;
    import flash.media.SoundChannel;

    public class DummySound implements ISound {

        private var playing:Boolean;
        private var playTime:int;
        private const duration:int = 12;

        public function DummySound() {
        }

        public function addEventListener(type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false):void {
            throw new Error("Method not implemented.");
        }

        public function removeEventListener(type:String, listener:Function, useCapture:Boolean = false):void {
            throw new Error("Method not implemented.");
        }

        public function dispatchEvent(event:flash.events.Event):Boolean {
            throw new Error("Method not implemented.");
        }

        public function hasEventListener(type:String):Boolean {
            throw new Error("Method not implemented.");
        }

        public function willTrigger(type:String):Boolean {
            throw new Error("Method not implemented.");
        }

        public function play(startTime:Number = 0, loopCount:int = 0, soundTransform:SoundTransform = null):SoundChannel {
            playing = true;
            return new SoundChannel();
        }

        public function forward():void {
            playTime++;
            if (duration >= playTime) {
                playing = false;
            }
        }
    }
}
