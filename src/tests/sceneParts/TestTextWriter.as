package tests.sceneParts {

    import tests.Assert;
    import classes.sceneParts.TextWriter;
    import classes.sceneContents.Scenario;
    import classes.uis.UIContainer;
    import flash.text.TextField;
    import flash.events.Event;

    public class TestTextWriter {
        public function TestTextWriter() {
            testExecute();
        }

        private function testExecute():void {
            var writer:TextWriter = new TextWriter();
            var scenario:Scenario = new Scenario();
            scenario.Text = "testText";

            var ui:UIContainer = new UIContainer();
            var textWindow:TextField = ui.TextWindow;

            writer.setUI(ui);
            writer.setScenario(scenario);

            Assert.areEqual(textWindow.text, "");

            writer.execute();
            writer.dispatchEvent(new Event(Event.ENTER_FRAME));

            // execute して 1フレーム経過
            Assert.areEqual(textWindow.text, "t");

            for (var i:int = 0; i < 10; i++) {
                writer.dispatchEvent(new Event(Event.ENTER_FRAME));
            }

            // 10フレーム経過
            Assert.areEqual(textWindow.text, "testText");

            // テキストの追加書き込みのテスト
            var additionScenario:Scenario = new Scenario();
            additionScenario.Text = "AddText";
            additionScenario.TextAddition = true;
            writer.setScenario(additionScenario);
            writer.execute();

            writer.dispatchEvent(new Event(Event.ENTER_FRAME));
            Assert.areEqual(textWindow.text, "testTextA");

            for (i = 0; i < 10; i++) {
                writer.dispatchEvent(new Event(Event.ENTER_FRAME));
            }

            // 最終的に２回分のテキストが連結されて入る。
            Assert.areEqual(textWindow.text, "testTextAddText");

            var scn:Scenario = new Scenario();
            scn.Text = "newText";

            writer.setScenario(scn);
            writer.execute();

            // セットした段階でテキストはリセット
            Assert.areEqual(textWindow.text, "");

            writer.dispatchEvent(new Event(Event.ENTER_FRAME));
            Assert.areEqual(textWindow.text, "n");

            writer.execute();

            // 途中で execute() を実行したので、本来はいるはずだったテキストが一気に入力される。
            Assert.areEqual(textWindow.text, "newText");
        }
    }
}
