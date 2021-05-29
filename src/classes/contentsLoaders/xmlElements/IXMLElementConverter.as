package classes.contentsLoaders.xmlElements {

    public interface IXMLElementConverter {
        function get ElementName():String;
        function convert(scenarioElement:XML):*
    }
}
