package {


    import flash.display.Sprite;
    import flash.desktop.NativeApplication;
    import tests.Assert;
    import tests.uis.TestBitmapContainer;
    import tests.sceneParts.*
    import tests.animes.TestShake;

    public class Tester extends Sprite {
        public function Tester() {

            new TestAnimator();
            new TestShake();
            new TestImageDrawer();
            new TestTextWriter();
            new TestBitmapContainer();
            new TestBGMPlayer();
            new TestSEPlayer();

            trace("[Tester]" + " " + Assert.TestCounter + " 回のテストを完了しました");
            NativeApplication.nativeApplication.exit();
        }
    }
}
