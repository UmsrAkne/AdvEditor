package classes.contentsLoaders.xmlElements {

    public class TargetAttributeConverter {
        public static function getLayerIndexFromTargetName(targetName:String):int {
            if (targetName == "background") {
                return 0;
            }

            if (targetName == "main") {
                return 1;
            }

            if (targetName == "middle") {
                return 2;
            }

            if (targetName == "front") {
                return 3;
            }

            return 1;
        }
    }
}
