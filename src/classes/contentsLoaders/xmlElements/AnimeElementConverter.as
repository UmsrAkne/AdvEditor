package classes.contentsLoaders.xmlElements {

    import classes.sceneContents.Scenario;
    import classes.animes.*;

    public class AnimeElementConverter implements IXMLElementConverter {

        public static const NAME_ATTRIBUTE:String = "@name";
        public static const TARGET_ATTRIBUTE:String = "@target";

        public function AnimeElementConverter() {
        }

        public function get ElementName():String {
            return "anime";
        }

        public function convert(scenarioElement:XML, scenario:Scenario):void {
            if (!scenarioElement.hasOwnProperty(ElementName)) {
                return;
            }

            for each (var animeElement:XML in scenarioElement[ElementName]) {
                var anime:IAnimation = makeAnimationFromName(animeElement[NAME_ATTRIBUTE]);
                var attributes:XMLList = animeElement.attributes();
                for each (var attribute:XML in attributes) {
                    if (attribute.name() == NAME_ATTRIBUTE.substr(1)) {
                        continue;
                    }

                    if (!isNaN(parseFloat(attribute))) {
                        var propertyName:String = attribute.name();
                        anime[propertyName] = parseFloat(attribute);
                    }

                    if (attribute.name() == TARGET_ATTRIBUTE.substr(1)) {
                        anime.TargetLayerIndex = TargetAttributeConverter.getLayerIndexFromTargetName(String(attribute));
                    }

                    scenario.Animations.push(anime);
                }
            }
        }

        private function makeAnimationFromName(animationName:String):IAnimation {
            var anime:IAnimation;

            switch (animationName) {
                case "alphaChanger":
                    anime = new AlphaChanger();
                    break;
                case "shake":
                    anime = new Shake();
                    break;
            }

            if (anime == null) {
                throw new ArgumentError("name を IAnimation に変換できません");
            }

            return anime;
        }
    }
}