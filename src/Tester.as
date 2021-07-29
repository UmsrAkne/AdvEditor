package {

    import flash.display.Sprite;
    import flash.desktop.NativeApplication;
    import tests.Assert;
    import tests.uis.TestBitmapContainer;
    import tests.sceneParts.*;
    import tests.animes.*;
    import tests.contentsLoaders.*;
    import tests.contentsLoaders.xmlElements.*
    import tests.gameScenes.TestLoadingScene;
    import tests.sceneContents.TestBlinkOrder;
    import tests.sceneContents.TestLipOrder;
    import tests.contentsLoaders.xmlElements.TestBackVoiceElementConverter;
    import tests.contentsLoaders.xmlElements.TestStopElementConverter;
    import tests.contentsLoaders.TestThumbnailLoader;
    import tests.gameScenes.TestSelectionScene;
    import tests.contentsLoaders.TestConfiguration;
    import tests.animes.TestLoopSlide;

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
            new TestBackVoiceElementConverter();
            new TestDrawElementConverter();
            new TestStopElementConverter();
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
            new TestBGVPlayer();
            new TestThumbnailLoader();
            new TestSelectionScene();
            new TestChapterManager();
            new TestBound();
            new TestMaskSlide();
            new TestConfiguration();
            new TestLoopSlide();

            trace("[Tester]" + " " + Assert.TestCounter + " 回のテストを完了しました");
            NativeApplication.nativeApplication.exit();
        }
    }
}
