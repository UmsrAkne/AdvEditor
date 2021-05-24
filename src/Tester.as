package {


    import flash.display.Sprite;
    import tests.Assert;
    import flash.desktop.NativeApplication;
    import tests.sceneParts.TestTextWriter;

    public class Tester extends Sprite {
        public function Tester() {

            new TestTextWriter();

            trace("[Tester]" + " " + Assert.TestCounter + " 回のテストを完了しました");
            NativeApplication.nativeApplication.exit();
        }
    }
}
