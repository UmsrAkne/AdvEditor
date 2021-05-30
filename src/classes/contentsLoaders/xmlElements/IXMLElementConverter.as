package classes.contentsLoaders.xmlElements {

    import classes.sceneContents.Scenario;

    public interface IXMLElementConverter {
        function get ElementName():String;
        function convert(scenarioElement:XML, scenario:Scenario):void;
    }
}
