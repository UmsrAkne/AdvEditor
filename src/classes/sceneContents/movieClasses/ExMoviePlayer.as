package classes.sceneContents.movieClasses {

    import flash.media.Video;
    import flash.net.NetStream;
    import flash.net.NetConnection;
    import flash.display.Sprite;
    import flash.filesystem.File;
    import flash.events.Event;
    import flash.html.script.Package;
    import flash.html.script.Package;

    public class ExMoviePlayer extends Sprite implements IMoviePlayer {

        private var video:Video;
        private var netStream:NetStream;
        private var url:String;
        private var duration:Number;
        private var beforeEndEvendDispatched:Boolean = false;
        public var alphaIncrement:Number = 0.2;

        public function ExMoviePlayer(w:int = 320, h:int = 240) {
            video = new Video(w, h);
            addChild(video);
            var nc:NetConnection = new NetConnection();
            nc.connect(null);
            netStream = new NetStream(nc);
            netStream.client = {onMetaData: function(videoInfo:Object):void {
                duration = videoInfo.duration;
                dispatchEvent(new Event(MovieEvent.PLAY_START));
            }};

            video.attachNetStream(netStream);
            addEventListener(Event.ENTER_FRAME, enterFrameEventHandler);
        }

        public function play():void {
            netStream.close();
            netStream.play(url);
            beforeEndEvendDispatched = false;
        }

        public function resume():void {
            netStream.resume();
        }

        public function stop():void {
            netStream.close();
        }

        public function load():void {
            netStream.play(url);
            netStream.pause();
        }

        public function get Position():Number {
            return netStream.time;
        }

        public function set Position(pos:Number):void {
            netStream.seek(pos);
        }

        public function loadAndPlay():void {
            throw new Error("Method not implemented.");
        }

        public function pause():void {
            netStream.pause();
        }

        public function set URL(value:String):void {
            var f:File = new File(value);
            if (!f.exists) {
                throw ArgumentError("指定されたファイルが存在しない");
            }
            url = value;
        }

        public function get URL():String {
            return url;
        }

        public function get Duration():Number {
            return duration;
        }

        private function enterFrameEventHandler(event:Event):void {
            if (this.alpha <= 1) {
                alpha += alphaIncrement;
            }

            if (!beforeEndEvendDispatched) {
                if (Position >= duration - 0.05) {
                    dispatchEvent(new Event(MovieEvent.BEFORE_END));
                    beforeEndEvendDispatched = true;
                }
            }
        }

        public override function set alpha(value:Number):void {
            var currentAlpha:Number = super.alpha;
            super.alpha = value;
            if (currentAlpha < 1.0 && currentAlpha + value >= 1.0) {
                dispatchEvent(new Event(MovieEvent.APPEARING));
            }
        }

        public override function get alpha():Number {
            return super.alpha;
        }
    }
}
