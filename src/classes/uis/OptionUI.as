package classes.uis {

    import classes.sceneContents.Resource;
    import flash.display.Sprite;
    import flash.events.Event;
    import flash.text.TextField;
    import flash.events.KeyboardEvent;
    import flash.ui.Keyboard;
    import flash.text.TextFormat;

    public class OptionUI extends Sprite {

        private var textField:TextField = new TextField();
        private var res:Resource;

        public function OptionUI(r:Resource) {
            res = r;
            addChild(textField);
            textField.alpha = 0;
            textField.width = 800;
            textField.height = 300;
            textField.defaultTextFormat = new TextFormat("Courier", 26, 0xffffff);
        }

        public function show():void {
            textField.alpha = 0;
            textField.visible = true;
            updateStatus();
            addEventListener(Event.ENTER_FRAME, fadeIn);
        }

        public function hide():void {
            addEventListener(Event.ENTER_FRAME, fadeOut);
        }

        private function updateStatus():void {
            textField.text = "";
            textField.text += "voice 	<V " + res.voiceVolume + " v>" + "\n";
            textField.text += "BGVoice	<B " + res.backVoiceVolume + " b>" + "\n";
            textField.text += "BGMV 	<M " + res.bgmVolume + " m>" + "\n";
            textField.text += "se		<S " + res.seVolume + " s>" + "\n";
        }

        private function fadeIn(e:Event):void {
            trace(textField.alpha);
            textField.alpha += 0.2;
            if (textField.alpha > 1.0) {
                removeEventListener(Event.ENTER_FRAME, fadeIn);
                addEventListener(KeyboardEvent.KEY_DOWN, keyboardEventHandler);
            }
        }

        private function fadeOut(e:Event):void {
            textField.alpha -= 0.2;
            if (textField.alpha <= 0) {
                removeEventListener(Event.ENTER_FRAME, fadeOut);
            }
        }

        private function keyboardEventHandler(e:KeyboardEvent):void {
            if (e.keyCode == Keyboard.E) {
                removeEventListener(KeyboardEvent.KEY_DOWN, keyboardEventHandler);
                hide();
            }

            if (e.keyCode == Keyboard.V) {
                if (e.shiftKey) {
                    res.voiceVolume -= 0.05;
                } else {
                    res.voiceVolume += 0.05;
                }

                updateStatus();
            }

            if (e.keyCode == Keyboard.B) {
                if (e.shiftKey) {
                    res.backVoiceVolume -= 0.05;
                } else {
                    res.backVoiceVolume += 0.05;
                }

                updateStatus();
            }

            if (e.keyCode == Keyboard.S) {
                if (e.shiftKey) {
                    res.seVolume -= 0.05;
                } else {
                    res.seVolume += 0.05;
                }

                updateStatus();
            }

            if (e.keyCode == Keyboard.M) {
                if (e.shiftKey) {
                    res.bgmVolume -= 0.05;
                } else {
                    res.bgmVolume += 0.05;
                }

                updateStatus();
            }
        }
    }
}
