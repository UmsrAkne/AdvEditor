package classes.sceneContents.movieClasses {

    import flash.events.IEventDispatcher;

    public interface IMoviePlayer extends IEventDispatcher {

        function play():void;
        function stop():void;
        function pause():void;
        function resume():void;

        function load():void;
        function loadAndPlay():void;

        function set URL(value:String):void;
        function get URL():String;

        function get Position():Number;
        function set Position(pos:Number):void;

        function get Duration():Number;
    }
}
