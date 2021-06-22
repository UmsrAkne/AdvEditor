package tests.contentsLoaders {

    import classes.contentsLoaders.FaceDrawingOrderLoader;
    import flash.filesystem.File;
    import classes.sceneContents.Resource;
    import tests.Assert;
    import classes.sceneContents.BlinkOrder;
    import classes.sceneContents.LipOrder;

    public class TestFaceDrawingOrderLoader {
        public function TestFaceDrawingOrderLoader() {
            test();
        }

        private function test():void {
            var faceDrawingOrderLoader:FaceDrawingOrderLoader = new FaceDrawingOrderLoader(new File(File.applicationDirectory.nativePath));
            var xmlString:String = "<root>";

            xmlString += "<blinkOrders>";
            xmlString += "<order base=\"A01\" close=\"A02\" open=\"A03,A04,A05\"/>";
            xmlString += "<order base=\"A02\" close=\"A02\" open=\"A03,A04,A05\"/>";
            xmlString += "</blinkOrders>";

            xmlString += "<lipOrders>";
            xmlString += "<order base=\"A11\" close=\"A02\" open=\"A03,A04,A05\"/>";
            xmlString += "<order base=\"A12\" close=\"A02\" open=\"A03,A04,A05\"/>";
            xmlString += "</lipOrders>";

            xmlString += "</root>";

            var xmlList:XMLList = new XMLList(xmlString);

            faceDrawingOrderLoader.OrderXMLList = xmlList;

            var res:Resource = new Resource();
            faceDrawingOrderLoader.writeContentsTo(res);

            Assert.isTrue(res.BlinkOrdersByName.hasOwnProperty("A01"));
            Assert.areEqual(BlinkOrder(res.BlinkOrdersByName["A01"]).OpenImageNames.length, 3);

            Assert.isTrue(res.BlinkOrdersByName.hasOwnProperty("A02"));
            Assert.areEqual(BlinkOrder(res.BlinkOrdersByName["A02"]).OpenImageNames.length, 3);

            Assert.isTrue(res.LipOrdersByName.hasOwnProperty("A11"));
            Assert.areEqual(LipOrder(res.LipOrdersByName["A11"]).OpenImageNames.length, 3);

            Assert.isTrue(res.LipOrdersByName.hasOwnProperty("A12"));
            Assert.areEqual(LipOrder(res.LipOrdersByName["A12"]).OpenImageNames.length, 3);
        }
    }
}
