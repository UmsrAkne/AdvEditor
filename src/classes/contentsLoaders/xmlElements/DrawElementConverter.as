package classes.contentsLoaders.xmlElements {

    import classes.sceneContents.Scenario;
    import classes.sceneContents.ImageOrder;

    public class DrawElementConverter implements IXMLElementConverter {

        public static const A_ATTRIBUTE:String = "@a";
        public static const B_ATTRIBUTE:String = "@b";
        public static const C_ATTRIBUTE:String = "@c";

        public static const DEPTH_ATTRIBUTE:String = "@depth";
        public static const DELAY_ATTRIBUTE:String = "@delay";
        public static const TARGET_ATTRIBUTE:String = "@target";

        public function DrawElementConverter() {
        }

        public function get ElementName():String {
            return "draw";
        }

        public function convert(scenarioElement:XML, scenario:Scenario):void {
            if (!scenarioElement.hasOwnProperty(ElementName)) {
                return;
            }

            for each (var drawTag:XML in scenarioElement[ElementName]) {
                var order:ImageOrder = new ImageOrder();
                if (drawTag.hasOwnProperty(A_ATTRIBUTE) || drawTag.hasOwnProperty(B_ATTRIBUTE) || drawTag.hasOwnProperty(C_ATTRIBUTE)) {
                    order.names = new Vector.<String>();
                    order.names.push(drawTag[A_ATTRIBUTE]);
                    order.names.push(drawTag[B_ATTRIBUTE]);
                    order.names.push(drawTag[C_ATTRIBUTE]);
                }

                if (drawTag.hasOwnProperty(DEPTH_ATTRIBUTE)) {
                    order.drawingDepth = parseFloat(drawTag[DEPTH_ATTRIBUTE]);
                }

                if (drawTag.hasOwnProperty(DELAY_ATTRIBUTE)) {
                    order.delay = parseInt(drawTag[DELAY_ATTRIBUTE]);
                }

                if (drawTag.hasOwnProperty(TARGET_ATTRIBUTE)) {
                    order.Target = drawTag[TARGET_ATTRIBUTE];
                }

                scenario.DrawingOrder.push(order);
            }
        }
    }
}
