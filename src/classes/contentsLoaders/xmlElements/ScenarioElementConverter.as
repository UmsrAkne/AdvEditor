package classes.contentsLoaders.xmlElements {

    import classes.sceneContents.Scenario;

    public class ScenarioElementConverter implements IXMLElementConverter {

        public static const ENTRY_POINT_ATTRIBUTE:String = "@entryPoint";
        public static const IGNORE_ATTRIBUTE:String = "@ignore";
        public static const CHAPTER_NAME_ATTRIBUTE:String = "@chapterName";

        public function ScenarioElementConverter() {
        }

        public function get ElementName():String {
            return "scenario";
        }

        public function convert(scenarioElement:XML, scenario:Scenario):void {
            if (scenarioElement.name() != ElementName) {
                return;
            }

            scenario.ChapterName = scenarioElement[CHAPTER_NAME_ATTRIBUTE];

            if (scenarioElement.hasOwnProperty(ENTRY_POINT_ATTRIBUTE)) {
                if (scenarioElement[ENTRY_POINT_ATTRIBUTE] == "true") {
                    scenario.EntryPoint = true;
                }
            }

            if (scenarioElement.hasOwnProperty(IGNORE_ATTRIBUTE)) {
                if (scenarioElement[IGNORE_ATTRIBUTE] == "true") {
                    scenario.Ignore = true;
                }
            }
        }
    }
}
