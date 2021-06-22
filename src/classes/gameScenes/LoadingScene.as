package classes.gameScenes {

    import flash.display.Sprite;
    import flash.filesystem.File;
    import flash.events.Event;
    import classes.contentsLoaders.ILoader;
    import classes.contentsLoaders.ScenarioLoader;
    import classes.contentsLoaders.SoundLoader;
    import classes.contentsLoaders.ImageLoader;
    import classes.contentsLoaders.SettingLoader;
    import classes.sceneContents.Resource;
    import classes.contentsLoaders.FaceDrawingOrderLoader;

    public class LoadingScene extends Sprite {

        private var sceneDirectory:File;
        private var loaders:Vector.<ILoader> = new Vector.<ILoader>();
        private var loadingCount:int = 0;
        private var resouce:Resource = new Resource();

        public function LoadingScene(sceneDirectory:File) {
            this.sceneDirectory = sceneDirectory;
        }

        public function getResource():Resource {
            return resouce;
        }

        public function load():void {
            loaders.push(new ScenarioLoader(sceneDirectory));
            loaders.push(new SettingLoader(sceneDirectory));
            loaders.push(new FaceDrawingOrderLoader(sceneDirectory));
            loaders.push(new SoundLoader(sceneDirectory));
            loaders.push(new ImageLoader(sceneDirectory));

            loadingCount = loaders.length;

            for each (var l:ILoader in loaders) {
                l.CompleteEventDispatcher.addEventListener(Event.COMPLETE, completeEventHandler);
                l.load();
            }
        }

        private function completeEventHandler(e:Event):void {
            loadingCount--;

            if (loadingCount == 0) {
                for each (var l:ILoader in loaders) {
                    l.writeContentsTo(resouce);
                }

                dispatchEvent(new Event(Event.COMPLETE));
            }
        }
    }
}
