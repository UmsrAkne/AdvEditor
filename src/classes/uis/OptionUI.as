package classes.uis {

    import classes.sceneContents.Resource;
    import flash.display.Bitmap;
    import flash.display.BitmapData;
    import flash.display.Sprite;
    import flash.events.Event;
    import flash.events.KeyboardEvent;
    import flash.text.TextField;
    import flash.text.TextFormat;
    import flash.ui.Keyboard;

    public class OptionUI extends Sprite {

        private var textField:TextField = new TextField();
        private var bg:Bitmap;
        private var res:Resource;

        public function OptionUI(r:Resource) {
            res = r;
            bg = new Bitmap(new BitmapData(res.ScreenSize.width, res.ScreenSize.height, false, 0x0));
            addChild(bg);
            bg.alpha = 0;

            addChild(textField);
            textField.alpha = 0;
            textField.width = 800;
            textField.height = 300;
            textField.defaultTextFormat = new TextFormat("Courier", 26, 0xffffff);
        }

        public function show():void {
            textField.alpha = 0;
            textField.visible = true;
            bg.alpha = 0;
            bg.visible = true;
            updateStatus();
            addEventListener(Event.ENTER_FRAME, fadeIn);
        }

        public function hide():void {
            addEventListener(Event.ENTER_FRAME, fadeOut);
        }

        private function updateStatus():void {
            function zeroPadding(str:String):String {
                while (str.length < 3) {
                    str = "0" + str;
                }

                return str;
            }

            var vv:String = zeroPadding(Math.round(res.voiceVolume * 100).toString());
            var bv:String = zeroPadding(Math.round(res.backVoiceVolume * 100).toString());
            var mv:String = zeroPadding(Math.round(res.bgmVolume * 100).toString());
            var sv:String = zeroPadding(Math.round(res.seVolume * 100).toString());

            textField.text = "";
            textField.text += "voice 	<V   " + vv + "    v>" + "\n";
            textField.text += "BGVoice	<B   " + bv + "    b>" + "\n";
            textField.text += "BGMV 	<M   " + mv + "    m>" + "\n";
            textField.text += "se		<S   " + sv + "    s>" + "\n";
            textField.text += "end 'e' key";
        }

        private function fadeIn(e:Event):void {
            textField.alpha += 0.2;
            bg.alpha += 0.15;
            if (textField.alpha > 1.0) {
                bg.alpha = 0.75;
                removeEventListener(Event.ENTER_FRAME, fadeIn);
                addEventListener(KeyboardEvent.KEY_DOWN, keyboardEventHandler);
            }
        }

        private function fadeOut(e:Event):void {
            textField.alpha -= 0.2;
            bg.alpha -= 0.15;
            if (textField.alpha <= 0) {
                textField.visible = false;
                bg.alpha = 0;
                bg.visible = false;
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
