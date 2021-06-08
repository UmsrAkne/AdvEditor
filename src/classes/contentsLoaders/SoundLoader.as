package classes.contentsLoaders {

    import classes.sceneContents.Resource;
    import flash.events.EventDispatcher;
    import flash.filesystem.File;
    import flash.events.Event;
    import classes.sceneContents.SoundFile;

    public class SoundLoader implements ILoader {

        private var completeEventDispatcher:EventDispatcher = new EventDispatcher();
        private var sceneDirectory:File;

        private var voiceFiles:Vector.<File> = new Vector.<File>();
        private var seFiles:Vector.<File> = new Vector.<File>();
        private var bgmFiles:Vector.<File> = new Vector.<File>();

        public function SoundLoader(sceneDirectory:File) {
            this.sceneDirectory = sceneDirectory;
        }

        public function writeContentsTo(resource:Resource):void {
            var f:File;
            var snd:SoundFile;

            resource.Voices.push(null);
            resource.SEs.push(null);
            resource.BGMs.push(null);

            for each (f in voiceFiles) {
                snd = new SoundFile(f);
                resource.Voices.push(snd);
                snd.Index = resource.Voices.length - 1;
            }

            for each (f in seFiles) {
                snd = new SoundFile(f);
                resource.SEs.push(new SoundFile(f));
                snd.Index = resource.SEs.length - 1;
            }

            for each (f in bgmFiles) {
                snd = new SoundFile(f);
                resource.BGMs.push(new SoundFile(f));
                snd.Index = resource.BGMs.length - 1;
            }
        }

        public function load():void {
            voiceFiles = ContentsLoadUtil.getFileList(sceneDirectory.resolvePath("voices").nativePath);
            seFiles = ContentsLoadUtil.getFileList(sceneDirectory.resolvePath("../../commonResource/ses").nativePath);
            bgmFiles = ContentsLoadUtil.getFileList(sceneDirectory.resolvePath("../../commonResource/bgms").nativePath);
            completeEventDispatcher.dispatchEvent(new Event(Event.COMPLETE));
        }

        public function get CompleteEventDispatcher():EventDispatcher {
            return completeEventDispatcher;
        }

        public function get VoiceFiles():Vector.<File> {
            return voiceFiles;
        }

        public function get SEFiles():Vector.<File> {
            return seFiles;
        }

        public function get BGMFiles():Vector.<File> {
            return bgmFiles;
        }
    }
}
