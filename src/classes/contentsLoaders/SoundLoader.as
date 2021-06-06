package classes.contentsLoaders {

    import classes.sceneContents.Resource;
    import flash.events.EventDispatcher;
    import flash.filesystem.File;

    public class SoundLoader implements ILoader {

        private var completeEventDispatcher:EventDispatcher = new EventDispatcher();
        private var targetDirectories:Vector.<File> = new Vector.<File>();
        private var sceneDirectory:File;

        private var voiceFiles:Vector.<File> = new Vector.<File>();
        private var seFiles:Vector.<File> = new Vector.<File>();
        private var bgmFiles:Vector.<File> = new Vector.<File>();

        public function SoundLoader(sceneDirectory:File) {
            this.sceneDirectory = sceneDirectory;
            targetDirectories.push(new File(sceneDirectory.nativePath + "/voices"));
            targetDirectories.push(new File(sceneDirectory.resolvePath("../../commonResource/ses").nativePath));
            targetDirectories.push(new File(sceneDirectory.resolvePath("../../commonResource/bgms").nativePath));
        }

        public function writeContentsTo(resource:Resource):void {
        }

        public function load():void {
        }

        public function get CompleteEventDispatcher():EventDispatcher {
            return completeEventDispatcher;
        }
    }
}
