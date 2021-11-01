package classes.contentsLoaders.xmlElements {

    import classes.sceneContents.Scenario;
    import flash.filesystem.File;

    public class MovieElementConverter implements IXMLElementConverter {

        private static const FILE_NAMES_ATTRIBUTE:String = "@fileNames"

        private var movieDirectory:File;
        private var movieFileList:Array;

        public function MovieElementConverter(sceneDirectory:File) {
            movieDirectory = new File(sceneDirectory.nativePath + "/movies");
        }

        public function get ElementName():String {
            return "movie";
        }

        public function convert(scenarioElement:XML, scenario:Scenario):void {
            if (!scenarioElement.hasOwnProperty([ElementName])) {
                return;
            }

            var movieTag:XML = scenarioElement[ElementName][0];

            if (movieTag.hasOwnProperty(FILE_NAMES_ATTRIBUTE)) {
                var fileNames:Array = String(movieTag[FILE_NAMES_ATTRIBUTE]).split(",");
                for each (var fn:String in fileNames) {
                    fn += (fn.indexOf(".mp4") == -1) ? ".mp4" : "";
                    scenario.MovieFiles.push(new File(movieDirectory.nativePath + "/" + fn));
                }
            }
        }
    }
}
