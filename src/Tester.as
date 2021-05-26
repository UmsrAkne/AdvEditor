package {


    import flash.display.Sprite;
    import tests.Assert;
    import flash.desktop.NativeApplication;
    import tests.sceneParts.TestTextWriter;
    import tests.uis.TestBitmapContainer;
    import tests.sceneParts.TestImageDrawer;

    public class Tester extends Sprite {
        public function Tester() {

            new TestImageDrawer();
            new TestTextWriter();
            new TestBitmapContainer();

            trace("[Tester]" + " " + Assert.TestCounter + " 回のテストを完了しました");
            NativeApplication.nativeApplication.exit();
        }
    }
}
