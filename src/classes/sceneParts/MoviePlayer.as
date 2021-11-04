package classes.sceneParts {

    import classes.sceneContents.Resource;
    import classes.sceneContents.Scenario;
    import classes.sceneContents.movieClasses.MoviePlayerContainer;
    import classes.uis.UIContainer;
    import flash.filesystem.File;
    import classes.sceneContents.StopOrder;

    public class MoviePlayer implements IScenarioSceneParts {

        private var player:MoviePlayerContainer;
        private var currentFiles:Vector.<File>;
        private var stopRequest:Boolean;

        public function MoviePlayer(player:MoviePlayerContainer) {
            this.player = player;
        }

        public function execute():void {
            if (stopRequest) {
                player.stop();
                stopRequest = false;
            }

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
            if (scenario.StopOrders.length != 0) {
                for each (var stopOrder:StopOrder in scenario.StopOrders) {
                    if (stopOrder.Target == "movie") {
                        stopRequest = true;
                    }
                }
            }

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
