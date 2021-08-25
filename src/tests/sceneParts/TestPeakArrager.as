package tests.sceneParts {

    import classes.sceneParts.PeakArranger;
    import tests.Assert;

    public class TestPeakArrager {
        public function TestPeakArrager() {
            test();
        }

        private function test():void {
            var arranger:PeakArranger = new PeakArranger();
            Assert.areEqual(arranger.getArrage(0), 0);
            Assert.areEqual(arranger.getArrage(1), 0.5);

            //  桁数は少数以下第二位まで
            Assert.areEqual(arranger.getArrage(1), 0.66);

            Assert.areEqual(arranger.getArrage(2), 1);
            Assert.areEqual(arranger.getArrage(1.5), 1.1);

            // ここの時点で cache が 5 個となり、次の入力で一番古い要素が消える
            Assert.areEqual(arranger.getArrage(1.5), 1.4); //  7 / 5

            Assert.areEqual(arranger.getArrage(1.5), 1.5); //  7.5 / 5
        }
    }
}
