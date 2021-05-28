package classes.contentsLoaders {

    import flash.events.EventDispatcher;

    public interface ILoader {
        function getContents():*;
        function get CompleteEventDispatcher():EventDispatcher;
    }
}
