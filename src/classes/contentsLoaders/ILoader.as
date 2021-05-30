package classes.contentsLoaders {

    import flash.events.EventDispatcher;

    public interface ILoader {
        function getContents():*;
        function load():void;
        function get CompleteEventDispatcher():EventDispatcher;
    }
}
