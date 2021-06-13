package classes.gameScenes {

    import flash.display.Sprite;
    import flash.events.KeyboardEvent;
    import flash.events.Event;
    import flash.ui.Keyboard;
    import classes.uis.UIContainer;
    import classes.sceneParts.*
    import classes.sceneContents.Resource;
    import classes.sceneContents.Scenario;

    public class ScenarioScene extends Sprite {

        private var ui:UIContainer = new UIContainer();
        private var sceneParts:Vector.<IScenarioSceneParts> = new Vector.<IScenarioSceneParts>();
        private var animators:Vector.<Animator> = new Vector.<Animator>();
        private var resource:Resource;
        private var textWriter:TextWriter;
        private var lastExecuteScenario:Scenario;

        public function ScenarioScene() {
            addChild(ui);
            addEventListener(KeyboardEvent.KEY_DOWN, keyboardEventHandler);
            addEventListener(Event.ENTER_FRAME, enterFrameEventHandler);

            textWriter = new TextWriter();
            sceneParts.push(textWriter);

            sceneParts.push(new BGMPlayer());
            sceneParts.push(new SEPlayer());
            sceneParts.push(new VoicePlayer(0));
            sceneParts.push(new VoicePlayer(1));
            sceneParts.push(new VoicePlayer(2));

            sceneParts.push(new ImageDrawer(ui.getBitmapContainerFromIndex(0))); // background
            sceneParts.push(new ImageDrawer(ui.getBitmapContainerFromIndex(1))); // main
            sceneParts.push(new ImageDrawer(ui.getBitmapContainerFromIndex(2))); // middle
            sceneParts.push(new ImageDrawer(ui.getBitmapContainerFromIndex(3))); // front

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
                ui.AlignUI(resource.ScreenSize.clone());
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
                    parts.setScenario(scenario)
                }

                for each (parts in sceneParts) {
                    parts.execute();
                }

                lastExecuteScenario = scenario;
            }
        }

        private function enterFrameEventHandler(event:Event):void {
            for each (var animator:Animator in animators) {
                animator.executeAnimations();
            }
        }
    }
}
