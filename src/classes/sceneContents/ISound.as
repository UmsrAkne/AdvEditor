package classes.sceneContents {

    import flash.events.IEventDispatcher;
    import flash.media.SoundChannel;
    import flash.media.SoundTransform;

    /** テスト時、ダミーのサウンドをプレイヤークラスで使用するためのインターフェース */
    public interface ISound extends IEventDispatcher {
        function play(startTime:Number = 0, loopCount:int = 0, soundTransform:SoundTransform = null):SoundChannel;
    }
}
