package classes.animes {

    import flash.display.DisplayObject;

    public interface IAnimation {
        function execute():void;
        function stop():void;
        function get Valid():Boolean;
        function set Target(targetObject:DisplayObject):void;
    }
}
