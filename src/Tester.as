package {


    import flash.display.Sprite;
    import tests.Assert;

    public class Tester extends Sprite {
        public function Tester() {
            trace("[Tester]" + " " + Assert.TestCounter + " 回のテストを完了しました");
        }
    }
}
