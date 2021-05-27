package classes.animes {

    import flash.display.DisplayObject;

    public interface IAnimation {
        function execute():void;
        function stop():void;
        function get Valid():Boolean;
        function get AnimationName():String;
        function set Target(targetObject:DisplayObject):void;
        function set TargetLayerIndex(index:int):void;
        function get TargetLayerIndex():int;
    }
}
