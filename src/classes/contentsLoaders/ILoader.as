package classes.contentsLoaders {

    import flash.events.EventDispatcher;
    import classes.sceneContents.Resource;

    public interface ILoader {
        function writeContentsTo(resource:Resource):void;
        function load():void;
        function get CompleteEventDispatcher():EventDispatcher;
    }
}
