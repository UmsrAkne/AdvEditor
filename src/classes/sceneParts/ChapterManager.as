package classes.sceneParts {

    import classes.sceneContents.Scenario;
    import classes.uis.UIContainer;
    import classes.sceneContents.Resource;

    public class ChapterManager implements IScenarioSceneParts {

        private var resource:Resource;
        private var lastPassedChapterName:String;
        private var currentChapterName:String;

        public function execute():void {
        }

        public function setScenario(scenario:Scenario):void {
            if (scenario.ChapterName != "") {
                lastPassedChapterName = scenario.ChapterName;
            }
        }

        public function setUI(ui:UIContainer):void {
        }

        public function setResource(res:Resource):void {
            if (resource == null) {
                resource = res;
            }
        }

        /**
         * @return 次のチャプターの先頭部のインデックス。次のチャプターが存在しない場合は -1 を返します。
         */
        public function getNextChapterIndex():int {
            var lastPassedChapterIndex:int = 0;

            if (lastPassedChapterName != "") {
                lastPassedChapterIndex = resource.ChapterHeaderIndexByChapterName[lastPassedChapterName];
            }

            var index:int = -1;

            for (var key:String in resource.ChapterHeaderIndexByChapterName) {
                if (int(resource.ChapterHeaderIndexByChapterName[key]) > lastPassedChapterIndex) {
                    if (index == -1) {
                        index = resource.ChapterHeaderIndexByChapterName[key];
                    }

                    index = Math.min(index, resource.ChapterHeaderIndexByChapterName[key]);
                }
            }

            return index;
        }
    }
}
