package classes.contentsLoaders {
    import flash.events.EventDispatcher;

    public class ThumbnailLoader {

        private var completeEventDispathcer:EventDispatcher = new EventDispatcher();

        public function ThumbnailLoader() {
        }

        public function load():void {
        }

        public function get CompleteEventDispatcher():EventDispatcher {
            return completeEventDispathcer;
        }
    }
}
