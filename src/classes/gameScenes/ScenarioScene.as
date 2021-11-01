package classes.gameScenes {

    import classes.sceneContents.Resource;
    import classes.sceneContents.Scenario;
    import classes.sceneParts.*;
    import classes.uis.OptionUI;
    import classes.uis.UIContainer;
    import flash.desktop.NativeApplication;
    import flash.display.Sprite;
    import flash.events.Event;
    import flash.events.KeyboardEvent;
    import flash.ui.Keyboard;
    import classes.sceneParts.MoviePlayer;

    public class ScenarioScene extends Sprite {

        public static var SCENE_EXIT:String = "sceneExit";

        private var ui:UIContainer = new UIContainer();
        private var sceneParts:Vector.<IScenarioSceneParts> = new Vector.<IScenarioSceneParts>();
        private var animators:Vector.<Animator> = new Vector.<Animator>();
        private var resource:Resource;
        private var textWriter:TextWriter;
        private var bgmPlayer:BGMPlayer;
        private var chapterManager:ChapterManager = new ChapterManager();
        private var lastExecuteScenario:Scenario;
        private var optionUI:OptionUI;

        public function ScenarioScene() {
            addChild(ui);
            addEventListener(KeyboardEvent.KEY_DOWN, keyboardEventHandler);
            addEventListener(Event.ENTER_FRAME, enterFrameEventHandler);

            ui.TextWindow.text = "loading is completed";
            textWriter = new TextWriter();
            sceneParts.push(textWriter);

            sceneParts.push(chapterManager);

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

            sceneParts.push(new LipDrawer(ui.getBitmapContainerFromIndex(1))); // main
            sceneParts.push(new LipDrawer(ui.getBitmapContainerFromIndex(2))); // middle
            sceneParts.push(new LipDrawer(ui.getBitmapContainerFromIndex(3))); // front

            sceneParts.push(new MaskSetter(ui.getBitmapContainerFromIndex(0))); // background
            sceneParts.push(new MaskSetter(ui.getBitmapContainerFromIndex(1))); // main
            sceneParts.push(new MaskSetter(ui.getBitmapContainerFromIndex(2))); // middle
            sceneParts.push(new MaskSetter(ui.getBitmapContainerFromIndex(3))); // front

            sceneParts.push(new MoviePlayer(ui.getMoviePlayerContainerFromIndex(0)));

            for (var i:int = 0; i < 4; i++) {
                var animator:Animator = new Animator(ui.getBitmapContainerFromIndex(i));
                sceneParts.push(animator);
                animators.push(animator);
            }

            for each (var parts:IScenarioSceneParts in sceneParts) {
                parts.setUI(ui);
            }

            addEventListener(Event.ADDED_TO_STAGE, setActivateEventHandler);
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
                optionUI = new OptionUI(resource);
            }
        }

        private function keyboardEventHandler(event:KeyboardEvent):void {
            if (event.keyCode == Keyboard.ENTER) {
                playScenario();
            }

            if (event.keyCode == Keyboard.O) {
                optionUI.show();
                stage.focus = optionUI;
                addChild(optionUI);
            }

            if (event.keyCode == Keyboard.N) {
                var index:int = chapterManager.getNextChapterIndex();
                if (index > 0) {
                    textWriter.ScenarioCounter = index;
                    playScenario();
                }
            }

            if (event.keyCode == Keyboard.R && event.ctrlKey) {
                for each (var sp:IScenarioSceneParts in sceneParts) {
                    sp.dispose();
                }

                resource.dispose();
                removeChild(ui);
                ui.dispose();

                dispatchEvent(new Event(SCENE_EXIT));
            }

            if (event.keyCode == Keyboard.Q) {
                NativeApplication.nativeApplication.exit();
            }
        }

        private function playScenario():void {
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

        private function enterFrameEventHandler(event:Event):void {
            for each (var animator:Animator in animators) {
                animator.executeAnimations();
            }
        }

        private function setActivateEventHandler(event:Event):void {
            removeEventListener(Event.ADDED_TO_STAGE, setActivateEventHandler);
            stage.addEventListener(Event.ACTIVATE, resetFocus);
        }

        private function resetFocus(e:Event):void {
            if (stage) {
                stage.focus = this;
            }
        }
    }
}
