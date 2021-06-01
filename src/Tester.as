package {


    import flash.display.Sprite;
    import flash.desktop.NativeApplication;
    import tests.Assert;
    import tests.uis.TestBitmapContainer;
    import tests.sceneParts.*
    import tests.animes.TestShake;
    import tests.animes.TestAlphaChanger;
    import tests.contentsLoaders.TestScenarioLoader;
    import tests.contentsLoaders.xmlElements.*;

    public class Tester extends Sprite {
        public function Tester() {

            new TestAnimator();
            new TestScenarioLoader();
            new TestAlphaChanger();
            new TestShake();
            new TestImageDrawer();
            new TestTextWriter();
            new TestBitmapContainer();
            new TestBGMPlayer();
            new TestSEPlayer();
            new TestVoiceElement();
            new TestBGMElementConverter();
            new TestSEElementConverter();

            trace("[Tester]" + " " + Assert.TestCounter + " 回のテストを完了しました");
            NativeApplication.nativeApplication.exit();
        }
    }
}
