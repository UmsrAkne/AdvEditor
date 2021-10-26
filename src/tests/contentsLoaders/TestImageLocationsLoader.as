package tests.contentsLoaders {

    import classes.contentsLoaders.ImageLocationsLoader;
    import classes.sceneContents.Resource;
    import flash.filesystem.File;
    import tests.Assert;

    public class TestImageLocationsLoader {
        public function TestImageLocationsLoader() {
            test();
        }

        private function test():void {
            var locationsLoader:ImageLocationsLoader = new ImageLocationsLoader(new File("/testPath"));
            var resource:Resource = new Resource();

            // 何も入っていない状態で実行しても問題ないか確認する。
            locationsLoader.writeContentsTo(new Resource());

            var xmlText:String = "<root>";
            xmlText += "<location name=\"testImageA\" x=\"100\" y=\"200\" />";
            xmlText += "<location name=\"testImageB\" x=\"150\" y=\"250\" />";
            xmlText += "</root>";

            var testXML:XMLList = new XMLList(xmlText);
            locationsLoader.LocationXMLList = testXML;

            locationsLoader.writeContentsTo(resource);

            Assert.areEqual(resource.ImageDrawingPointByName["testImageA"].x, 100);
            Assert.areEqual(resource.ImageDrawingPointByName["testImageA"].y, 200);

            Assert.areEqual(resource.ImageDrawingPointByName["testImageB"].x, 150);
            Assert.areEqual(resource.ImageDrawingPointByName["testImageB"].y, 250);
        }
    }
}
