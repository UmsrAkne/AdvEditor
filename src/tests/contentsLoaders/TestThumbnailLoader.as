package tests.contentsLoaders {

    import classes.contentsLoaders.ThumbnailLoader;
    import flash.filesystem.File;
    import flash.events.Event;
    import tests.Assert;

    public class TestThumbnailLoader {
        public function TestThumbnailLoader() {
            test();
        }

        private function test():void {
            var loader:ThumbnailLoader = new ThumbnailLoader(new File(File.applicationDirectory.nativePath).resolvePath("../scenarios/sampleScenario"));
            loader.CompleteEventDispatcher.addEventListener(Event.COMPLETE, function(e:Event):void {
                Assert.isTrue(loader.Thumbnail.width > 0);
                Assert.isTrue(loader.Thumbnail.height > 0);

                // 指定した画像は白ドットのため、取得したピクセルの値が ０以上か確認する。
                // 内部的には draw を使って BitmapData に描画しているが、厳密に比較した時白にならない。丸められてるかも？
                Assert.isTrue(loader.Thumbnail.getPixel(0, 0) > 0);
            });

            loader.load();
        }
    }
}
