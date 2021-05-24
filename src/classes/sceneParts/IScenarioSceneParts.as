package classes.sceneParts {

    import classes.sceneContents.Scenario;
    import classes.uis.UIContainer;

    public interface IScenarioSceneParts {
        function execute():void;
        function setScenario(scenario:Scenario):void;
        function setUI(ui:UIContainer):void;
    }
}
