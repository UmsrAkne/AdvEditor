package classes.contentsLoaders.xmlElements {

    import classes.sceneContents.Scenario;
    import flash.geom.Point;
    import flash.display.Shape;
    import flash.display.Graphics;
    import classes.sceneContents.MaskOrder;

    public class MaskElementConverter implements IXMLElementConverter {

        public static const A_ATTRIBUTE:String = "@a";
        public static const B_ATTRIBUTE:String = "@b";
        public static const C_ATTRIBUTE:String = "@c";
        public static const D_ATTRIBUTE:String = "@d";
        public static const E_ATTRIBUTE:String = "@e";
        public static const F_ATTRIBUTE:String = "@f";
        public static const TARGET_ATTRIBUTE:String = "@target";

        public function MaskElementConverter() {

        }

        public function get ElementName():String {
            return "mask";
        }

        public function convert(scenarioElement:XML, scenario:Scenario):void {
            if (!scenarioElement.hasOwnProperty(ElementName)) {
                return;
            }

            var maskTags:Vector.<XML> = new Vector.<XML>();

            for each (var tag:XML in scenarioElement[ElementName]) {
                maskTags.push(tag);
            }

            for each (var maskTag:XML in maskTags) {
                var poss:Vector.<String> = new Vector.<String>();
                poss.push(maskTag[A_ATTRIBUTE]);
                poss.push(maskTag[B_ATTRIBUTE]);
                poss.push(maskTag[C_ATTRIBUTE]);
                poss.push(maskTag[D_ATTRIBUTE]);
                poss.push(maskTag[E_ATTRIBUTE]);
                poss.push(maskTag[F_ATTRIBUTE]);

                var points:Vector.<Point> = new Vector.<Point>();

                for each (var posString:String in poss) {
                    if (posString == "") {
                        continue;
                    }

                    var ps:Array = posString.split(",");
                    points.push(new Point(parseFloat(ps[0]), parseFloat(ps[1])));
                }

                var maskShape:Shape = new Shape();
                var g:Graphics = maskShape.graphics;
                g.lineStyle(0, 0x000000, 1);
                g.beginFill(0x000000, 1);

                for each (var p:Point in points) {
                    g.lineTo(p.x, p.y);
                }

                g.endFill();
                var maskOrder:MaskOrder = new MaskOrder();
                maskOrder.shape = maskShape;
                scenario.Masks.push(maskOrder);

                if (tag.hasOwnProperty(TARGET_ATTRIBUTE)) {
                    maskOrder.TargetLayerIndex = TargetAttributeConverter.getLayerIndexFromTargetName(String(tag[TARGET_ATTRIBUTE]));
                }
            }
        }
    }
}
