package classes.contentsLoaders {

    import classes.sceneContents.Scenario;
    import flash.events.EventDispatcher;
    import flash.events.Event;
    import flash.display.Sprite;
    import flash.net.URLLoader;
    import flash.net.URLRequest;
    import flash.filesystem.File;
    import classes.contentsLoaders.xmlElements.*;
    import classes.sceneContents.Resource;
    import flash.desktop.NativeApplication;
    import classes.contentsLoaders.xmlElements.MovieElementConverter;

    public class ScenarioLoader implements ILoader {

        private var scenarios:Vector.<Scenario> = new Vector.<Scenario>();
        private var completeEventDispatcher:Sprite = new Sprite();
        private var sceneDirectory:File;
        private var scenarioXML:XMLList;

        public function ScenarioLoader(sceneDirectory:File) {
            this.sceneDirectory = sceneDirectory;
        }

        public function writeContentsTo(resource:Resource):void {
            resource.scenarios = scenarios;

            for (var i:int = 0; i < scenarios.length; i++) {
                var s:Scenario = scenarios[i];
                if (s.ChapterName != "") {
                    if (!resource.ScenariosByChapterName.hasOwnProperty(s.ChapterName)) {
                        resource.ScenariosByChapterName[s.ChapterName] = new Vector.<Scenario>();
                        resource.ChapterHeaderIndexByChapterName[s.ChapterName] = i;
                    }

                    Vector.<Scenario>(resource.ScenariosByChapterName[s.ChapterName]).push(s);
                }
            }
        }

        public function load():void {
            if (scenarioXML == null) {

                // プロパティ経由で ScenarioXML に値をセット可能なため、null の場合にのみ、ロード処理を行い、
                // その後で XML を Scenario に変換する。

                var urlLoader:URLLoader = new URLLoader();
                urlLoader.addEventListener(Event.COMPLETE, function(e:Event):void {
                    try {
                        scenarioXML = new XMLList(URLLoader(e.target).data);
                    } catch (error:TypeError) {
                        trace(error.message);
                        NativeApplication.nativeApplication.exit();
                        return;
                    }

                    scenarios = makeScenarios(scenarioXML);
                    CompleteEventDispatcher.dispatchEvent(new Event(Event.COMPLETE));
                });


                urlLoader.load(new URLRequest(sceneDirectory.resolvePath("texts/scenario.xml").nativePath));
                return;
            }

            scenarios = makeScenarios(scenarioXML);
            CompleteEventDispatcher.dispatchEvent(new Event(Event.COMPLETE));
        }

        public function set ScenarioXML(value:XMLList):void {
            scenarioXML = value;
        }

        public function get CompleteEventDispatcher():EventDispatcher {
            return completeEventDispatcher;
        }

        private function makeScenarios(xmlList:XMLList):Vector.<Scenario> {
            var vec:Vector.<Scenario> = new Vector.<Scenario>();

            var commonResourceDirectory:File = new File(File.applicationDirectory.nativePath).resolvePath("../commonResource");

            var elementConverters:Vector.<IXMLElementConverter> = new Vector.<IXMLElementConverter>();
            elementConverters.push(new ScenarioElementConverter());
            elementConverters.push(new AnimeElementConverter());
            elementConverters.push(new BGMElementConverter(commonResourceDirectory));
            elementConverters.push(new ImageElementConverter(sceneDirectory));
            elementConverters.push(new SEElementConverter(commonResourceDirectory));
            elementConverters.push(new TextElementConverter());
            elementConverters.push(new VoiceElementConverter(sceneDirectory));
            elementConverters.push(new DrawElementConverter());
            elementConverters.push(new MaskElementConverter());
            elementConverters.push(new BackVoiceElementConverter(sceneDirectory));
            elementConverters.push(new StopElementConverter());
            elementConverters.push(new MovieElementConverter(sceneDirectory));

            for each (var scenarioTag:XML in xmlList["scenario"]) {
                var scenario:Scenario = new Scenario();
                for (var i:int = 0; i < elementConverters.length; i++) {
                    elementConverters[i].convert(scenarioTag, scenario);
                }

                if (scenario.Ignore) {
                    continue;
                }

                vec.push(scenario);
            }

            return vec;
        }
    }
}
