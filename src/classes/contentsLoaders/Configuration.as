package classes.contentsLoaders {

    import flash.events.EventDispatcher;

    public class Configuration {

        private var completeEventDispatcher:EventDispatcher = new EventDispatcher();

        public function Configuration() {

        }

        public function get CompleteEventDispatcher():EventDispatcher {
            return completeEventDispatcher;
        }
    }
}
