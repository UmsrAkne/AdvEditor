package classes.sceneParts {

    public class PeakArranger {

        private var cache:Vector.<Number> = new Vector.<Number>();
        private var _chacheSize:int = 5;
        private var _max:Number = 0;

        public function PeakArranger() {
        }

        public function getArrage(value:Number):Number {
            cache.push(value);
            _max = Math.max(value, _max);

            while (cache.length > _chacheSize) {
                cache.shift();
            }

            var total:Number = 0;
            for each (var n:Number in cache) {
                total += n;
            }

            return Math.floor(total / cache.length * 100) / 100;
        }

        public function clearCache():void {
            cache = new Vector.<Number>();
        }

        public function get max():Number {
            return _max;
        }
    }
}
