package classes.sceneContents {

    /** シーン中に書き込む画像の詳細なデータを保持するクラスです。 */
    public class ImageOrder {

        public var names:Vector.<String> = new Vector.<String>();
        public var indexes:Vector.<int> = new Vector.<int>();
        public var targetLayerIndex:int = 1;

        public function ImageOrder() {
        }
    }
}
