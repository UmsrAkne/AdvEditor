package classes.sceneParts {
    import classes.sceneContents.Scenario;
    import classes.uis.UIContainer;
    import classes.sceneContents.ImageOrder;
    import classes.uis.BitmapContainer;
    import flash.display.Bitmap;
    import flash.display.BitmapData;
    import classes.sceneContents.Resource;
    import flash.events.EventDispatcher;
    import flash.events.Event;
    import flash.geom.ColorTransform;
    import flash.display.Sprite;
    import flash.geom.Matrix;
    import flash.geom.Point;
    import flash.geom.Rectangle;
    import classes.sceneContents.ImageFile;

    public class ImageDrawer implements IScenarioSceneParts {

        private var needBitmapAddition:Boolean;
        private var needBitmapDrawing:Boolean;

        private var bitmapContainer:BitmapContainer;
        private var resource:Resource;
        private var currentOrder:ImageOrder;
        private var drawingOrder:ImageOrder;
        private var delayCounter:int;
        private var totalDrawingDepth:Number = 0;
        private var lastSettingRotation:int = 0;
        private var defaultScale:Number = 1.0;

        private var enterFrameEventDispatcher:EventDispatcher = new Sprite();

        public function ImageDrawer(targetBitmapContainer:BitmapContainer) {
            bitmapContainer = targetBitmapContainer;
        }

        public function execute():void {
            if (!needBitmapAddition && !needBitmapDrawing) {
                return;
            }

            // 最初のガード節を抜けた時点で、新規か上書きのいずれかの画像描画命令が出ていることが確定。
            // どちらの場合であっても、 drawToFront(e:Event) が動作中では、ターゲットに不正な値が入るので、
            // stopDrawing() を使用して処理を停止させる。

            if (enterFrameEventDispatcher.hasEventListener(Event.ENTER_FRAME)) {
                stopDrawing();
            }

            if (needBitmapAddition) {
                var bmds:Vector.<BitmapData> = new Vector.<BitmapData>();
                var drawingLocations:Vector.<Point> = new Vector.<Point>();
                var w:int;
                var h:int;
                for each (var name:String in currentOrder.names) {
                    if (name != "") {
                        var b:BitmapData = ImageFile(resource.ImageFilesByName[name]).getBitmapData();
                        bmds.push(b);
                        if (resource.ImageDrawingPointByName.hasOwnProperty(name)) {
                            drawingLocations.push(Point(resource.ImageDrawingPointByName[name]).clone());
                        } else {
                            drawingLocations.push(new Point());
                        }

                        w = Math.max(w, b.width);
                        h = Math.max(h, b.height);
                    }
                }

                var bitmap:Bitmap = new Bitmap(new BitmapData(w, h, true, currentOrder.backgroundColor));

                for (var i:int = 0; i < bmds.length; i++) {
                    bitmap.bitmapData.draw(bmds[i], new Matrix(1, 0, 0, 1, drawingLocations[i].x, drawingLocations[i].y));
                }

                var matrix:Matrix;

                if (currentOrder.statusInherit && bitmapContainer.Front != null) {
                    bitmap.scaleX = bitmapContainer.Front.scaleX;
                    bitmap.scaleY = bitmapContainer.Front.scaleY;
                    bitmap.x = bitmapContainer.Front.x;
                    bitmap.y = bitmapContainer.Front.y;

                    if (lastSettingRotation != 0) {
                        matrix = bitmap.transform.matrix;
                        matrix.translate(bitmap.width / 2 * -1, bitmap.height / 2 * -1);
                        matrix.rotate(lastSettingRotation * Math.PI / 180);
                        matrix.translate(bitmap.width / 2, bitmap.height / 2);
                        bitmap.transform.matrix = matrix;
                    }
                } else {
                    if (!currentOrder.ScaleIsDefault) {
                        bitmap.scaleX = currentOrder.Scale;
                        bitmap.scaleY = currentOrder.Scale;
                    } else {
                        bitmap.scaleX = defaultScale;
                        bitmap.scaleY = defaultScale;
                    }

                    bitmap.x = currentOrder.x;
                    bitmap.y = currentOrder.y;

                    if (currentOrder.rotation != 0) {
                        matrix = bitmap.transform.matrix;
                        matrix.translate(bitmap.width / 2 * -1, bitmap.height / 2 * -1);
                        matrix.rotate(currentOrder.rotation * Math.PI / 180);
                        matrix.translate(bitmap.width / 2, bitmap.height / 2);
                        bitmap.transform.matrix = matrix;
                    }

                    lastSettingRotation = currentOrder.rotation;
                }

                bitmap.alpha = 0;
                bitmapContainer.add(bitmap);
            }

            if (needBitmapDrawing) {
                enterFrameEventDispatcher.addEventListener(Event.ENTER_FRAME, drawToFront);
            }

            needBitmapDrawing = false;
            needBitmapAddition = false;
        }

        public function setScenario(scenario:Scenario):void {
            if (scenario.ImageOrders.length == 0 && scenario.DrawingOrder.length == 0) {
                needBitmapDrawing = false;
                needBitmapAddition = false;
                return;
            }

            if (scenario.ImageOrders.length > 0) {
                for each (var order:ImageOrder in scenario.ImageOrders) {
                    if (order.targetLayerIndex == bitmapContainer.LayerIndex) {
                        currentOrder = order;
                        needBitmapAddition = true;
                    }
                }
            }

            if (scenario.DrawingOrder.length > 0) {
                for each (order in scenario.DrawingOrder) {
                    if (order.targetLayerIndex == bitmapContainer.LayerIndex) {
                        drawingOrder = order;
                        delayCounter = order.delay;
                        needBitmapDrawing = true;
                    }
                }
            }
        }

        public function setUI(ui:UIContainer):void {
            // 実装無し
        }

        public function setResource(res:Resource):void {
            this.resource = res;
            defaultScale = res.defaultScale;
        }

        private function drawToFront(e:Event):void {
            if (delayCounter > 0) {
                delayCounter--;
                return;
            }

            var bitmap:Bitmap = bitmapContainer.Front;

            for each (var name:String in drawingOrder.names) {
                if (name != "") {
                    var p:Point = getPointFromImageName(name);
                    var bd:BitmapData = ImageFile(resource.ImageFilesByName[name]).getBitmapData();
                    bitmap.bitmapData.draw(bd, new Matrix(1, 0, 0, 1, p.x, p.y), new ColorTransform(1, 1, 1, drawingOrder.drawingDepth));
                }
            }

            totalDrawingDepth += drawingOrder.drawingDepth;
            if (totalDrawingDepth >= 1.2) {
                stopDrawing();
            }
        }

        private function stopDrawing():void {
            while (enterFrameEventDispatcher.hasEventListener(Event.ENTER_FRAME)) {
                enterFrameEventDispatcher.removeEventListener(Event.ENTER_FRAME, drawToFront);
            }

            delayCounter = 0;
            totalDrawingDepth = 0;

            var bitmap:Bitmap = bitmapContainer.Front;
            for each (var name:String in drawingOrder.names) {
                if (name != "") {
                    var p:Point = getPointFromImageName(name)
                    var bd:BitmapData = ImageFile(resource.ImageFilesByName[name]).getBitmapData();
                    bitmap.bitmapData.copyPixels(bd, new Rectangle(0, 0, bd.width, bd.height), new Point(p.x, p.y), null, null, true);
                }
            }
        }

        public function get EnterFrameEventDispatcher():EventDispatcher {
            return enterFrameEventDispatcher;
        }

        private function getPointFromImageName(targetImageName:String):Point {
            if (resource.ImageDrawingPointByName[targetImageName] != null) {
                return Point(resource.ImageDrawingPointByName[targetImageName]).clone();
            } else {
                return new Point();
            }
        }

        public function dispose():void {
        }
    }
}
