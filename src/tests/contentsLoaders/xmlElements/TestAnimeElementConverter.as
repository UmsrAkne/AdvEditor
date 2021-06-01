package tests.contentsLoaders.xmlElements {

    import classes.contentsLoaders.xmlElements.AnimeElementConverter;
    import classes.sceneContents.Scenario;
    import tests.Assert;
    import classes.animes.Shake;
    import classes.animes.AlphaChanger;

    public class TestAnimeElementConverter {
        public function TestAnimeElementConverter() {
            testConvert();
        }

        private function testConvert():void {
            var animeElementConverter:AnimeElementConverter = new AnimeElementConverter();
            var scenario:Scenario = new Scenario();
            var xmlText:String = "<scenario>  <anime name=\"shake\" strength=\"25\" /> ";
            xmlText += "<anime name=\"alphaChanger\" amount=\"0.5\" target=\"background\" /> ";
            xmlText += "</scenario>"
            var xml:XML = new XML(xmlText);

            animeElementConverter.convert(xml, scenario);
            Assert.isTrue(scenario.Animations[0] is Shake);
            Assert.areEqual(scenario.Animations[0]["strength"], 25);

            Assert.isTrue(scenario.Animations[1] is AlphaChanger);
            Assert.areEqual(scenario.Animations[1].TargetLayerIndex, 0);
        }
    }
}
