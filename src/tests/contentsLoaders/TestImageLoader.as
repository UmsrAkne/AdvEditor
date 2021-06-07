package tests.contentsLoaders {

    import classes.contentsLoaders.ImageLoader;
    import classes.sceneContents.Resource;
    import flash.filesystem.File;
    import flash.display.BitmapData;
    import tests.Assert;

    public class TestImageLoader {
        public function TestImageLoader() {
            testWriteContents();
        }

        private function testWriteContents():void {
            var imageLoader:ImageLoader = new ImageLoader(new File(File.applicationDirectory.nativePath));
            var res:Resource = new Resource();

            var imageFiles:Vector.<File> = new Vector.<File>();
            var bitmapDatas:Vector.<BitmapData> = new Vector.<BitmapData>();

            imageFiles.push(new File("/images/A001.png"));
            imageFiles.push(new File("/images/A002.png"));
            imageFiles.push(new File("/images/A003.png"));

            bitmapDatas.push(new BitmapData(5, 5, true, 0x0));
            bitmapDatas.push(new BitmapData(5, 5, true, 0x0));
            bitmapDatas.push(new BitmapData(5, 5, true, 0x0));

            imageLoader.ImageFiles = imageFiles;
            imageLoader.BitmapDatas = bitmapDatas;

            imageLoader.writeContentsTo(res);

            Assert.areEqual(res.BitmapDatas.length, 3);
            Assert.areEqual(res.BitmapDatas[0], bitmapDatas[0]);
            Assert.areEqual(res.BitmapDatas[1], bitmapDatas[1]);
            Assert.areEqual(res.BitmapDatas[2], bitmapDatas[2]);

            Assert.areEqual(res.BitmapDatasByName["A001.png"], bitmapDatas[0]);
            Assert.areEqual(res.BitmapDatasByName["A001"], bitmapDatas[0]);
            Assert.areEqual(res.BitmapDatasByName["A002.png"], bitmapDatas[1]);
            Assert.areEqual(res.BitmapDatasByName["A002"], bitmapDatas[1]);
            Assert.areEqual(res.BitmapDatasByName["A003.png"], bitmapDatas[2]);
            Assert.areEqual(res.BitmapDatasByName["A003"], bitmapDatas[2]);
        }
    }
}
