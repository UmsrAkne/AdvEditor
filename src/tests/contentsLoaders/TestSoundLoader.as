package tests.contentsLoaders {

    import classes.contentsLoaders.SoundLoader;
    import flash.filesystem.File;
    import classes.sceneContents.Resource;
    import tests.Assert;
    import classes.sceneContents.SoundFile;

    public class TestSoundLoader {
        public function TestSoundLoader() {
            testWriteResource();
        }

        private function testWriteResource():void {
            var soundLoader:SoundLoader = new SoundLoader(new File(File.applicationDirectory.nativePath));

            soundLoader.VoiceFiles.push(new File("/testFile/v2"));
            soundLoader.SEFiles.push(new File("/testFiles/s2"));
            soundLoader.SEFiles.push(new File("/testFiles/s3"));
            soundLoader.BGMFiles.push(new File("/testFiles/bgm1"));
            soundLoader.BGMFiles.push(new File("/testFiles/bgm2"));
            soundLoader.BGMFiles.push(new File("/testFiles/bgm3"));

            soundLoader.BGVFiles.push(new File("/testFiles/bgm1"));
            soundLoader.BGVFiles.push(new File("/testFiles/bgm2"));
            soundLoader.BGVFiles.push(new File("/testFiles/bgm3"));

            var res:Resource = new Resource();

            soundLoader.writeContentsTo(res);

            Assert.areEqual(res.Voices.length, 2);
            Assert.areEqual(res.SEs.length, 3);
            Assert.areEqual(res.BGMs.length, 4);
            Assert.areEqual(res.BGVs.length, 4);

            Assert.areEqual(res.Voices[0], null);
            Assert.areEqual(res.SEs[0], null);
            Assert.areEqual(res.BGMs[0], null);
            Assert.areEqual(res.BGVs[0], null);

            Assert.areNotEqual(res.Voices[1], null);
            Assert.areNotEqual(res.SEs[1], null);
            Assert.areNotEqual(res.BGMs[1], null);
            Assert.areNotEqual(res.BGVs[1], null);
        }
    }
}
