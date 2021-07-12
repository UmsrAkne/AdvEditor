package classes.gameScenes {

    import flash.desktop.NativeApplication;
    import flash.display.Sprite;
    import flash.events.Event;
    import flash.events.KeyboardEvent;
    import flash.ui.Keyboard;
    import classes.sceneContents.Resource;
    import classes.sceneContents.Scenario;
    import classes.sceneParts.*;
    import classes.uis.UIContainer;

    public class ScenarioScene extends Sprite {

        private var ui:UIContainer = new UIContainer();
        private var sceneParts:Vector.<IScenarioSceneParts> = new Vector.<IScenarioSceneParts>();
        private var animators:Vector.<Animator> = new Vector.<Animator>();
        private var resource:Resource;
        private var textWriter:TextWriter;
        private var bgmPlayer:BGMPlayer;
        private var lastExecuteScenario:Scenario;

        public function ScenarioScene() {
            addChild(ui);
            addEventListener(KeyboardEvent.KEY_DOWN, keyboardEventHandler);
            addEventListener(Event.ENTER_FRAME, enterFrameEventHandler);

            textWriter = new TextWriter();
            sceneParts.push(textWriter);

            bgmPlayer = new BGMPlayer();
            sceneParts.push(bgmPlayer);
            sceneParts.push(new SEPlayer());
            sceneParts.push(new VoicePlayer(0));
            sceneParts.push(new VoicePlayer(1));
            sceneParts.push(new VoicePlayer(2));

            // VoicePlayer のインデックス 0-2 に対応
            sceneParts.push(new BGVPlayer(0));
            sceneParts.push(new BGVPlayer(1));
            sceneParts.push(new BGVPlayer(2));

            sceneParts.push(new ImageDrawer(ui.getBitmapContainerFromIndex(0))); // background
            sceneParts.push(new ImageDrawer(ui.getBitmapContainerFromIndex(1))); // main
            sceneParts.push(new ImageDrawer(ui.getBitmapContainerFromIndex(2))); // middle
            sceneParts.push(new ImageDrawer(ui.getBitmapContainerFromIndex(3))); // front

            // BlinkDrawer は background に対しては不要。
            sceneParts.push(new BlinkDrawer(ui.getBitmapContainerFromIndex(1))); // main
            sceneParts.push(new BlinkDrawer(ui.getBitmapContainerFromIndex(2))); // middle
            sceneParts.push(new BlinkDrawer(ui.getBitmapContainerFromIndex(3))); // front

            sceneParts.push(new MaskSetter(ui.getBitmapContainerFromIndex(0))); // background
            sceneParts.push(new MaskSetter(ui.getBitmapContainerFromIndex(1))); // main
            sceneParts.push(new MaskSetter(ui.getBitmapContainerFromIndex(2))); // middle
            sceneParts.push(new MaskSetter(ui.getBitmapContainerFromIndex(3))); // front

            for (var i:int = 0; i < 4; i++) {
                var animator:Animator = new Animator(ui.getBitmapContainerFromIndex(i));
                sceneParts.push(animator);
                animators.push(animator);
            }

            for each (var parts:IScenarioSceneParts in sceneParts) {
                parts.setUI(ui);
            }
        }

        public function setResource(r:Resource):void {
            if (resource == null) {
                resource = r;
                ui.TextWindowImage.bitmapData = resource.UIImageContainer.TextWindowImage.bitmapData.clone();
                ui.AlignUI(resource.ScreenSize.clone());

                for each (var parts:IScenarioSceneParts in sceneParts) {
                    parts.setResource(r);
                }

                bgmPlayer.execute();
            }
        }

        private function keyboardEventHandler(event:KeyboardEvent):void {
            if (event.keyCode == Keyboard.ENTER) {
                if (textWriter.ScenarioCounter >= resource.scenarios.length) {
                    return;
                }

                var scenario:Scenario = resource.scenarios[textWriter.ScenarioCounter];

                if (scenario == lastExecuteScenario) {
                    textWriter.setScenario(scenario);
                    textWriter.execute();
                    lastExecuteScenario = scenario;
                    return;
                }

                for each (var parts:IScenarioSceneParts in sceneParts) {
                    parts.setScenario(scenario);
                }

                for each (parts in sceneParts) {
                    parts.execute();
                }

                lastExecuteScenario = scenario;
            }

            if (event.keyCode == Keyboard.Q) {
                NativeApplication.nativeApplication.exit();
            }
        }

        private function enterFrameEventHandler(event:Event):void {
            for each (var animator:Animator in animators) {
                animator.executeAnimations();
            }
        }
    }
}
