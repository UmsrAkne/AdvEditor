package tests.animes {

    import classes.animes.LoopSlide;
    import flash.display.Bitmap;
    import flash.display.BitmapData;
    import flash.geom.Rectangle;
    import tests.Assert;

    public class TestLoopSlide {
        public function TestLoopSlide() {
            test();
        }

        private function test():void {
            var loopSlide:LoopSlide = new LoopSlide();
            loopSlide.degree = 315;
            loopSlide.reflectCount = 1;
            var bitmap:Bitmap = new Bitmap(new BitmapData(200, 200, false, 0x0));
            loopSlide.Target = bitmap;
            var dummyStageRect:Rectangle = new Rectangle(-1, -2, 50, 50);
            loopSlide.StageRect = dummyStageRect;
            loopSlide.speed = 10;

            var i:int = 0;

            var 端に達した:Boolean;

            for (i = 0; i < 50; i++) {
                if (Math.abs(bitmap.x) >= 150 && Math.abs(bitmap.y) >= 150) {
                    // 描画領域がオブジェクトの端に到達した時に通るブロック
                    端に達した = true;
                    break;
                }

                loopSlide.execute();
            }

            Assert.isTrue(端に達した);

            var 元の位置に戻った:Boolean;

            for (i = 0; i < 50; i++) {
                if (Math.abs(bitmap.x) < 2 && Math.abs(bitmap.y) < 2) {
                    // 描画領域がおよそ 0,0 に到達した時に通るブロック
                    元の位置に戻った = true;
                }

                loopSlide.execute();
            }

            Assert.isTrue(元の位置に戻った);

            // 端に達した, 元の位置に戻った の両方が true になっていれば、
            // 端まで描画領域が移動後、往復して元の位置に戻ったことになる。

            // loopSlide.reflectCount = 1 なので、一度壁にぶつかって、もう一度壁にぶつかったら動かなくなる。
            Assert.isFalse(loopSlide.Valid);
        }
    }
}
