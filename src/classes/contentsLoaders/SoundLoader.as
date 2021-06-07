package classes.contentsLoaders {

    import classes.sceneContents.Resource;
    import flash.events.EventDispatcher;
    import flash.filesystem.File;
    import flash.events.Event;
    import classes.sceneContents.SoundFile;
    import flash.media.Sound;

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

            for each (f in voiceFiles) {
                snd = new SoundFile(f);
                resource.Voices.push(snd);

                // 入力されるインデックスが１多いように見えるが、予め空のサウンドがベクターに一つ入るので間違いではない。
                snd.Index = resource.Voices.length;
            }

            for each (f in seFiles) {
                snd = new SoundFile(f);
                resource.SEs.push(new SoundFile(f));
                snd.Index = resource.SEs.length;
            }

            for each (f in bgmFiles) {
                snd = new SoundFile(f);
                resource.BGMs.push(new SoundFile(f));
                snd.Index = resource.BGMs.length;
            }
        }

        public function load():void {
            voiceFiles = ContentsLoadUtil.getFileList(sceneDirectory.nativePath + "/voices");
            seFiles = ContentsLoadUtil.getFileList(sceneDirectory.resolvePath("../../commonResource/ses").nativePath);
            bgmFiles = ContentsLoadUtil.getFileList(sceneDirectory.resolvePath("../../commonResource/bgms").nativePath);
            completeEventDispatcher.dispatchEvent(new Event(Event.COMPLETE));
        }

        public function get CompleteEventDispatcher():EventDispatcher {
            return completeEventDispatcher;
        }
    }
}
