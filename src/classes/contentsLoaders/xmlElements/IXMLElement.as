package classes.contentsLoaders.xmlElements {

    public interface IXMLElement {
        function get ElementName():String;
        function get AttributeNames():Vector.<String>;
        function convert():*
    }
}
