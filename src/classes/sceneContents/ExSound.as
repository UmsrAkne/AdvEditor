package classes.sceneContents {

    import flash.events.Event;
    import flash.media.Sound;
    import flash.media.SoundChannel;
    import flash.media.SoundTransform;

    /** flash.media.Sound を ISound として扱うためのラッパークラスです。 */
    public class ExSound implements ISound {

        private var sound:Sound;

        public function ExSound(sound:Sound) {
            this.sound = sound;
        }

        public function play(startTime:Number = 0, loopCount:int = 0, soundTransform:SoundTransform = null):SoundChannel {
            return sound.play(startTime, loopCount, soundTransform);
        }

        public function addEventListener(type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false):void {
            sound.addEventListener(type, listener, useCapture, priority, useWeakReference);
        }

        public function removeEventListener(type:String, listener:Function, useCapture:Boolean = false):void {
            sound.removeEventListener(type, listener, useCapture);
        }

        public function dispatchEvent(event:flash.events.Event):Boolean {
            return sound.dispatchEvent(event);
        }

        public function hasEventListener(type:String):Boolean {
            return hasEventListener(type);
        }

        public function willTrigger(type:String):Boolean {
            return willTrigger(type);
        }

    }
}
