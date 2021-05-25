package tests.uis {

    import classes.uis.BitmapContainer;
    import flash.display.Bitmap;
    import flash.display.BitmapData;
    import classes.uis.BitmapContainer;
    import tests.Assert;
    import flash.events.Event;

    public class TestBitmapContainer {
        public function TestBitmapContainer() {
            testAdd();
        }

        public function testAdd():void {
            var bitmapContainer:BitmapContainer = new BitmapContainer();

            var bmps:Vector.<Bitmap> = new Vector.<Bitmap>();
            bmps.push(new Bitmap(new BitmapData(10, 10)));
            bmps.push(new Bitmap(new BitmapData(10, 10)));
            bmps.push(new Bitmap(new BitmapData(10, 10)));
            bmps.push(new Bitmap(new BitmapData(10, 10)));
            bmps.push(new Bitmap(new BitmapData(10, 10)));
            bmps.push(new Bitmap(new BitmapData(10, 10)));

            var eventDispatched:Boolean;
            function eventTest(e:Event):void {
                eventDispatched = true;
            }

            bitmapContainer.addEventListener(BitmapContainer.BITMAP_ADDED, eventTest);
            bitmapContainer.add(bmps[0]);

            Assert.isTrue(eventDispatched);
            Assert.areEqual(bitmapContainer.Front, bmps[0]);

            for (var i:int = 0; i < 5; i++) {
                bitmapContainer.add(bmps[i]);
                Assert.areEqual(bitmapContainer.Front, bmps[i])
            }
        }
    }
}
