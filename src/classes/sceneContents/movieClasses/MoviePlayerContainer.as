package classes.sceneContents.movieClasses {

    import flash.display.Sprite;
    import flash.display.DisplayObject;
    import flash.events.Event;

    public class MoviePlayerContainer extends Sprite {

        private var urls:Vector.<String>;
        private var currentMovieIndex:int = 0;
        private var firstMoviewPlayed:Boolean = false;
        private var cursorDirection:int = 1;
        private var urlsBuffer:Vector.<String> = new Vector.<String>;

        public function MoviePlayerContainer() {
        }

        public function setPlayers(playerA:IMoviePlayer, playerB:IMoviePlayer):void {
            addChild(DisplayObject(playerB));
            addChild(DisplayObject(playerA));
        }

        public function setURLs(URLs:Vector.<String>):void {
            if (switching()) {
                urlsBuffer = URLs;
                frontPlayer.addEventListener(MovieEvent.APPEARING, frontPlayerAppearing);
            } else {
                urls = URLs;
                currentMovieIndex = 0;
                firstMoviewPlayed = false;
                frontPlayer.dispatchEvent(new Event(MovieEvent.BEFORE_END));
            }
        }

        public function play():void {
            frontPlayer.URL = urls[currentMovieIndex];
            frontPlayer.play();
            DisplayObject(frontPlayer).alpha = 0;
            reattachBeforeEndEvent(frontPlayer);
            firstMoviewPlayed = true;
        }

        public function stop():void {
            this.visible = 0;
            frontPlayer.stop();
            backPlayer.stop();
        }

        private function get frontPlayer():IMoviePlayer {
            return IMoviePlayer(getChildAt(numChildren - 1));
        }

        private function get backPlayer():IMoviePlayer {
            return IMoviePlayer(getChildAt(0));
        }

        private function reattachBeforeEndEvent(targetPlayer:IMoviePlayer):void {
            for (var i:int = 0; i < numChildren; i++) {
                getChildAt(i).removeEventListener(MovieEvent.BEFORE_END, nextPlay);
            }

            targetPlayer.addEventListener(MovieEvent.BEFORE_END, nextPlay);
        }

        private function nextPlay(e:Event):void {
            currentMovieIndex = getNextIndex();
            var bp:IMoviePlayer = backPlayer;
            bp.URL = urls[currentMovieIndex];
            bp.play()
            reattachBeforeEndEvent(bp);
            DisplayObject(bp).alpha = 0;
            addChild(DisplayObject(bp));
            firstMoviewPlayed = true;
        }

        private function frontPlayerAppearing(e:Event):void {
            var player:IMoviePlayer = IMoviePlayer(e.target);

            for (var i:int = 0; i < 5; i++) {
                if (!player.hasEventListener(MovieEvent.APPEARING)) {
                    break;
                }
                player.removeEventListener(MovieEvent.APPEARING, frontPlayerAppearing);
            }

            backPlayer.pause();
            if (urlsBuffer.length == 0) {
                return;
            } else {
                backPlayer.addEventListener(MovieEvent.APPEARING, frontPlayerAppearing);
                urls = urlsBuffer;
                currentMovieIndex = 0;
                firstMoviewPlayed = false;
                urlsBuffer = new Vector.<String>();
                player.dispatchEvent(new Event(MovieEvent.BEFORE_END));
            }
        }

        /**
         * ２つのプレイヤーを切り替えしている最中かどうかを取得します
         */
        public function switching():Boolean {
            return (DisplayObject(frontPlayer).alpha < 1 || DisplayObject(backPlayer).alpha < 1);
        }

        /**
         * 次に再生すべき動画のインデックスを取得します
         */
        private function getNextIndex():int {
            if (urls.length == 1 || !firstMoviewPlayed) {
                return 0;
            }

            if (urls.length == 2) {
                return 1;
            }

            var tempIndex:int = currentMovieIndex + cursorDirection;
            if (tempIndex >= urls.length || tempIndex <= 0) {
                cursorDirection *= -1;
            }

            return currentMovieIndex + cursorDirection;
        }
    }
}
