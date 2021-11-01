package classes.sceneParts {

    import classes.sceneContents.Resource;
    import classes.sceneContents.Scenario;
    import classes.sceneContents.movieClasses.MoviePlayerContainer;
    import classes.uis.UIContainer;
    import flash.filesystem.File;

    public class MoviePlayer implements IScenarioSceneParts {

        private var player:MoviePlayerContainer;
        private var currentFiles:Vector.<File>;

        public function MoviePlayer(player:MoviePlayerContainer) {
            this.player = player;
        }

        public function execute():void {
            if (currentFiles != null && currentFiles.length != 0) {
                var urls:Vector.<String> = new Vector.<String>();
                for each (var f:File in currentFiles) {
                    urls.push(f.nativePath);
                }

                player.setURLs(urls);
                player.play();
                currentFiles = null;
            }
        }

        public function setScenario(scenario:Scenario):void {
            if (scenario.MovieFiles.length == 0) {
                return;
            }

            currentFiles = scenario.MovieFiles;
        }

        public function setUI(ui:UIContainer):void {
        }

        public function setResource(res:Resource):void {
        }

        public function dispose():void {
        }
    }
}
