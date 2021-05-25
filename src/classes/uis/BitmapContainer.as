package classes.uis {

    import flash.display.Sprite;
    import flash.display.Bitmap;
    import flash.events.Event;

    public class BitmapContainer extends Sprite {

        public static const BITMAP_ADDED:String = "bitmap_added";

        public var layerCapacity:int = 4;

        private var bitmaps:Vector.<Bitmap> = new Vector.<Bitmap>();

        public function BitmapContainer() {
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
    }
}
