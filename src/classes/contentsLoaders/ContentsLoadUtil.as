package classes.contentsLoaders {

    import flash.filesystem.File;

    public class ContentsLoadUtil {

        static public function getFileList(path:String):Vector.<File> {
            var directory:File = new File(path);
            var files:Array = directory.getDirectoryListing();
            var fileVec:Vector.<File> = new Vector.<File>();

            for (var i:int = 0; i < files.length; i++) {
                fileVec.push(files[i]);
            }

            return fileVec;
        }
    }
}
