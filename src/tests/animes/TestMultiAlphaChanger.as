package tests.animes {

    import classes.animes.MultiAlphaChanger;
    import flash.display.Sprite;

    public class TestMultiAlphaChanger {
        public function TestMultiAlphaChanger() {
            targetTest();
        }

        private function targetTest():void {
            var multiAlphaChanger:MultiAlphaChanger = new MultiAlphaChanger();

            var parentSprite:Sprite = new Sprite();
            var childSprite1:Sprite = new Sprite();
            var childSprite2:Sprite = new Sprite();

            parentSprite.addChild(childSprite1);
            parentSprite.addChild(childSprite2);

            multiAlphaChanger.Target = childSprite2;
        }
    }
}
