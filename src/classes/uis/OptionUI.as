package classes.uis {

    import classes.sceneContents.Resource;
    import flash.display.Sprite;
    import flash.events.Event;
    import flash.text.TextField;

    public class OptionUI extends Sprite {

        private var textField:TextField = new TextField();
        private var res:Resource;

        public function OptionUI(r:Resource) {
            res = r;
        }

        public function show():void {
            textField.alpha = 0;
            textField.visible = true;
            addEventListener(Event.ENTER_FRAME, fadeIn);
        }

        public function hide():void {
            addEventListener(Event.ENTER_FRAME, fadeOut);
        }

        private function fadeIn(e:Event):void {
            textField.alpha += 0.2;
            if (textField.alpha > 1.0) {
                removeEventListener(Event.ENTER_FRAME, fadeIn);
            }
        }

        private function fadeOut(e:Event):void {
            textField.alpha -= 0.2;
            if (textField.alpha <= 0) {
                removeEventListener(Event.ENTER_FRAME, fadeOut);
            }
        }
    }
}
