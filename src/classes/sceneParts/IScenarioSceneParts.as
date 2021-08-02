package classes.sceneParts {

    import classes.sceneContents.Scenario;
    import classes.uis.UIContainer;
    import classes.sceneContents.Resource;

    public interface IScenarioSceneParts {
        function execute():void;
        function setScenario(scenario:Scenario):void;
        function setUI(ui:UIContainer):void;
        function setResource(res:Resource):void;
        function dispose():void;
    }
}
