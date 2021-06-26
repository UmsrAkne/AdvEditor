package classes.contentsLoaders.xmlElements {

    import classes.sceneContents.Scenario;
    import classes.sceneContents.StopOrder;

    public class StopElementConverter implements IXMLElementConverter {

        public static const TARGET_ATTRIBUTE:String = "@target";
        public static const INDEX_ATTRIBUTE:String = "@index";

        public function get ElementName():String {
            return "stop";
        }

        public function convert(scenarioElement:XML, scenario:Scenario):void {
            if (!scenarioElement.hasOwnProperty(ElementName)) {
                return;
            }

            for each (var stopTag:XML in scenarioElement[ElementName]) {
                var order:StopOrder = new StopOrder();
                order.Target = String(stopTag[TARGET_ATTRIBUTE]);
                var index:int = parseInt(String(stopTag[INDEX_ATTRIBUTE]));
                if (!isNaN(index)) {
                    order.Index = index;
                }

                scenario.StopOrders.push(order);
            }
        }
    }
}
