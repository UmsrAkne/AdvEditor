package classes.sceneParts {

    import classes.sceneContents.Scenario;

    public interface IScenarioSceneParts {
        function execute():void;
        function setScenario(scenario:Scenario):void;
    }
}
