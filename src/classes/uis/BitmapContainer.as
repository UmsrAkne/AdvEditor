package classes.uis {

    import flash.display.Sprite;
    import flash.display.Bitmap;
    import flash.events.Event;

    public class BitmapContainer extends Sprite {

        public static const BITMAP_ADDED:String = "bitmap_added";

        public var layerCapacity:int = 4;

        private var bitmaps:Vector.<Bitmap> = new Vector.<Bitmap>();
        private var layerIndex:int;

        public function BitmapContainer(layerIndex:int) {
            this.layerIndex = layerIndex;
        }

        public function add(bitmap:Bitmap):void {
            bitmaps.unshift(bitmap);
            dispatchEvent(new Event(BITMAP_ADDED));

            if (bitmaps.length > layerCapacity) {
                while (bitmaps.length > layerCapacity) {
                    var delBitmap:Bitmap = bitmaps.pop();
                    if (delBitmap.bitmapData != null) {
                        delBitmap.bitmapData.dispose();
                        delBitmap = null;
                    }
                }
            }
        }

        public function get Front():Bitmap {
            return bitmaps[0];
        }

        public function get LayerIndex():int {
            return layerIndex;
        }
    }
}
