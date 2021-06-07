package classes.contentsLoaders {

    import classes.sceneContents.Resource;
    import flash.events.EventDispatcher;
    import flash.filesystem.File;

    public class SettingLoader implements ILoader {

        private var completeEventDispatcher:EventDispatcher = new EventDispatcher();
        private var sceneDirectory:File;
        private var settingXML:XML;

        public function SettingLoader(sceneDirectory:File) {
            this.sceneDirectory = sceneDirectory;
        }

        public function writeContentsTo(resource:Resource):void {
            throw new Error("Method not implemented.");
        }

        public function load():void {
        }

        public function get CompleteEventDispatcher():EventDispatcher {
            return completeEventDispatcher;
        }

        /**
         * テスト用プロパティ。ターゲットが null の場合にのみセット可能。
         * @param value
         */
        public function set SettingXML(value:XML):void {
            if (!settingXML) {
                settingXML = value;
            }
        }
    }
}
