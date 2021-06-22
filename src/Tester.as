package {


    import flash.display.Sprite;
    import flash.desktop.NativeApplication;
    import tests.Assert;
    import tests.uis.TestBitmapContainer;
    import tests.sceneParts.*;
    import tests.animes.*;
    import tests.contentsLoaders.TestScenarioLoader;
    import tests.contentsLoaders.xmlElements.*;
    import tests.contentsLoaders.TestSoundLoader;
    import tests.contentsLoaders.TestImageLoader;
    import tests.contentsLoaders.TestSettingLoader;
    import tests.gameScenes.TestLoadingScene;
    import tests.sceneParts.TestBlinkDrawer;
    import tests.sceneContents.TestBlinkOrder;
    import tests.sceneContents.TestLipOrder;
    import tests.contentsLoaders.TestFaceDrawingOrderLoader;

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
            new TestImageElementConverter();
            new TestAnimeElementConverter();
            new TestTextElementConverter();
            new TestScenarioElementConverter();
            new TestDrawElementConverter();
            new TestSoundLoader();
            new TestImageLoader();
            new TestSettingLoader();
            new TestLoadingScene();
            new TestMaskElementConverter();
            new TestMaskSetter();
            new TestSlide();
            new TestMultiAlphaChanger();
            new TestBlinkDrawer();
            new TestBlinkOrder();
            new TestLipOrder();
            new TestFaceDrawingOrderLoader();

            trace("[Tester]" + " " + Assert.TestCounter + " 回のテストを完了しました");
            NativeApplication.nativeApplication.exit();
        }
    }
}
