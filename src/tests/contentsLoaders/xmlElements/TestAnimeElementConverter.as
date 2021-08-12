package tests.contentsLoaders.xmlElements {

    import classes.contentsLoaders.xmlElements.AnimeElementConverter;
    import classes.sceneContents.Scenario;
    import tests.Assert;
    import classes.animes.Shake;
    import classes.animes.AlphaChanger;
    import classes.animes.LoopSlide;
    import flash.display.Sprite;
    import flash.geom.Rectangle;
    import flash.display.Bitmap;
    import flash.display.BitmapData;

    public class TestAnimeElementConverter {
        public function TestAnimeElementConverter() {
            testConvert();
        }

        private function testConvert():void {
            var animeElementConverter:AnimeElementConverter = new AnimeElementConverter();
            var scenario:Scenario = new Scenario();
            var xmlText:String = "<scenario>  <anime name=\"shake\" strength=\"25\" /> ";
            xmlText += "<anime name=\"alphaChanger\" amount=\"0.5\" target=\"background\" /> ";
            xmlText += "<anime name=\"slide\" speed=\"10\" direction=\"right\" /> ";
            xmlText += "</scenario>";
            var xml:XML = new XML(xmlText);

            animeElementConverter.convert(xml, scenario);
            Assert.isTrue(scenario.Animations[0] is Shake);
            Assert.areEqual(scenario.Animations[0]["strength"], 25);

            Assert.isTrue(scenario.Animations[1] is AlphaChanger);
            Assert.areEqual(scenario.Animations[1].TargetLayerIndex, 0);

            var bmp:Bitmap = new Bitmap(new BitmapData(200, 200));
            scenario.Animations[2].Target = bmp;
            LoopSlide(scenario.Animations[2]).StageRect = new Rectangle(0, 0, 100, 100);
            Assert.isTrue(scenario.Animations[2] is LoopSlide);

            scenario.Animations[2].execute();
            scenario.Animations[2].execute();
            scenario.Animations[2].execute();

            // xml から文字列で "right" を入力しているので、bmp は横方向にスライドする。
            // つまり、|x| は 0 より大きく、 y は 0 のままの状態。 
            Assert.isTrue(Math.abs(bmp.x) > 0 && bmp.y == 0);
        }
    }
}
