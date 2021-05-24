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
                writer.dispatchEvent(new Event(Event.ENTER_FRAME))
            }

            // 10フレーム経過
            Assert.areEqual(textWindow.text, "testText");
        }
    }
}
