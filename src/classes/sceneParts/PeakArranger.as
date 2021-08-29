package classes.sceneParts {

    public class PeakArranger {

        private var cache:Vector.<Number> = new Vector.<Number>();
        private var _chacheSize:int = 5;
        private var _max:Number = 0;
        private var _divisionCount:int = 1;

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

        public function getLevel(value:Number):int {
            _max = Math.max(value, max);

            if (_divisionCount == 1 || value < 0.01) {
                return 0;
            }

            if (value == _max) {
                return _divisionCount - 1;
            }

            var levelLines:Vector.<Number> = new Vector.<Number>();
            for (var i:int = 0; i < _divisionCount; i++) {
                levelLines.push(_max / _divisionCount * i);
            }

            for (i = 0; i < levelLines.length; i++) {
                if (levelLines[i] > value) {
                    break;
                }
            }

            return i;
        }

        public function clearCache():void {
            cache = new Vector.<Number>();
        }

        public function get max():Number {
            return _max;
        }

        public function set divisonCount(value:int):void {
            _divisionCount = value;
        }
    }
}
