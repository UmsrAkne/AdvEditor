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
    import classes.contentsLoaders.UIImageLoader;
    import classes.contentsLoaders.ImageLocationsLoader;

    public class LoadingScene extends Sprite {

        private var sceneDirectory:File;
        private var loaders:Vector.<ILoader> = new Vector.<ILoader>();
        private var loadingCount:int = 0;
        private var imageLoader:ImageLoader;
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
            loaders.push(new ImageLocationsLoader(sceneDirectory));
            loaders.push(new FaceDrawingOrderLoader(sceneDirectory));
            loaders.push(new SoundLoader(sceneDirectory));
            loaders.push(new UIImageLoader(new File(File.applicationDirectory.nativePath).resolvePath("../commonResource")));

            imageLoader = new ImageLoader(sceneDirectory);
            loaders.push(imageLoader);

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

                imageLoader.loadUsingImages(resouce);
                resouce.sceneDirectory = sceneDirectory
                dispatchEvent(new Event(Event.COMPLETE));
            }
        }
    }
}
