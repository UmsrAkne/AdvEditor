## ADVEditory XML specification
	ADVEditory で使用する XML では、全ての要素名、属性名の命名規則としてローワーキャメルケースを用いる。

	ex : anime
	ex : fileName

## scenario.xml	ファイルの仕様

現状では `<scenario>` 以外のタグはネストの必要のない空要素となる。  
以下に登場する `<scenario>` 以外の要素は全て `<scenario>` の子として記述する。

	ex : <scenario> <text string="display" /> </scenario>

	<xxx> が属性名
	"@xxx" が属性名
	フォーマットは属性の定義クラス : 属性名
	
	<anime>
		AnimeElementConverter:"@name"
			
			Allowed animation name list.
				
			"alphaChanger"
			"multiAlphaChanger"
			"shake"
			"slide" ("LoopSlide" と同じ動作)
			"loopSlide"
			"maskSlide"
			"flashing"
			"scaleChanger"
			"bound"
	
		AnimeElementConverter:"@target"
	
			Allowed target name list.

			"background"	: (Layer index 0)
			"main"			: (Layer index 1)
			"middle"		: (Layer index 2)
			"front"			: (Layer index 3)
			
		
		Anime element's attribute list for each animation name.
		
		数値の表記が無いものはデフォルト値が "0" となっている。

			alphaChanger   duration = 12
			alphaChanger   amount = 0.1
			alphaChanger   delay

			bound   degree
			bound   strength = 1
			bound   loopCount
			bound   duration
			bound   delay
			bound   interval

			flashing   cycle = 4
			flashing   duration = 24
			flashing   delay
			flashing   loopCount
			flashing   TopParentRect
			flashing   interval

			loopSlide(slide)   interval
			loopSlide(slide)   distance
			loopSlide(slide)   reflectCount
			loopSlide(slide)   degree
			loopSlide(slide)   speed
			loopSlide(slide)   StageRect

			maskSlide    speed
			maskSlide    degree
			maskSlide    distance

			multiAlphaChanger   front = 0.1
			multiAlphaChanger   backs = -0.1
			multiAlphaChanger   frontDelay
			multiAlphaChanger   backsDelay
			multiAlphaChanger   strength

			scaleChanger   strength = 0.1
			scaleChanger   delay
			scaleChanger   total

			shake   strength = 5
			shake   duration = 24
			shake   loopCount
			shake   delay 
			shake   interval

			slide   degree
			slide   speed
			slide   distance

			slide   direction = "";

				文字列を値に入力すると degree の値が変化する。

				"up":
					degree = 0;

				"rightUp":
					degree = 45;

				"right":
					degree = 90;

				"rightDown":
					degree = 135;

				"down":
					degree = 180;

				"leftDown":
					degree = 225;

				"left":
					degree = 270;

				"leftUP":
					degree = 315;

	<bgm>
		BGMElementConverter:"@fileName"
		BGMElementConverter:"@number"
		BGMElementConverter:"@volume"

	<backVoice>
		BackVoiceElementConverter:"@characterChannel"
		BackVoiceElementConverter:"@names"
		BackVoiceElementConverter:"@volume"

	<draw>
		a-d までの属性内にはファイル名を入力する
		DrawElementConverter:"@a"
		DrawElementConverter:"@b"
		DrawElementConverter:"@c"
		DrawElementConverter:"@d"
		DrawElementConverter:"@depth"
		DrawElementConverter:"@delay"
		DrawElementConverter:"@target"

	<image>
		a-d までの属性内にはファイル名を入力する
		ImageElementConverter:"@a"
		ImageElementConverter:"@b"
		ImageElementConverter:"@c"
		ImageElementConverter:"@d"

		ImageElementConverter:"@backgroundColor"
			8 桁の 16 進数(ARGB)で指定する。 ex : <image backgroundColor="0xffffffff" />

		ImageElementConverter:"@rotation"
		ImageElementConverter:"@scale"
		ImageElementConverter:"@statusInherit"

		ImageElementConverter:"@target"
			入力する値は anime.target と同様

		ImageElementConverter:"@x"
		ImageElementConverter:"@y"

	<mask>

		a-f までの属性値には座標を入力する
		ex <mask a="0,0" b="0,100" c="100,100" d="0,100" />
		MaskElementConverter:"@a"
		MaskElementConverter:"@b"
		MaskElementConverter:"@c"
		MaskElementConverter:"@d"
		MaskElementConverter:"@e"
		MaskElementConverter:"@f"

		MaskElementConverter:"@target"
			入力する値は anime.target と同様。

	<movie>
		fileNames には mp4 ファイル名をカンマ区切りで入力する。拡張子は無くても可。
		ファイルはシナリオディレクトリの "movies/" 配下から読み込まれる。
		MovieElementConverter:"@fileNames"
	
	<se>
		SEElementConverter:"@fileName"
		SEElementConverter:"@number"
		SEElementConverter:"@repeatCount"
		SEElementConverter:"@volume"

	<scenario>
		ScenarioElementConverter:"@chapterName"
		ScenarioElementConverter:"@entryPoint"
		ScenarioElementConverter:"@ignore"

	<stop>
		StopElementConverter:"@index"
		StopElementConverter:"@target"

	<text>
		TextElementConverter:"@string"
		TextElementConverter:"@textAddition"

	<voice>
		VoiceElementConverter:"@channel"
		VoiceElementConverter:"@fileName"
		VoiceElementConverter:"@number"
		VoiceElementConverter:"@volume"

## faceDrawingOrder.xml の仕様

scenarioDirectory/texts に配置。  
それぞれ blinkOrders, lipOrders で order タグを囲む。  
base, close に関してはファイル名のみ。  
open に関しては `,` で区切って複数のファイル名が入力可。  

	<blinkOrders>
		<order base="B01" close="B02" open="B03,B04,B05" />
		<order base="B02" close="B02" open="B03,B04,B05" />
	</blinkOrders>

	<lipOrders>
		<order base="B02" close="B02" open="B03,B04,B05" />
	</lipOrders>

## setting.xmlの仕様

	<setting>
		SettingLoader:"@width"
		SettingLoader:"@height"
		SettingLoader:"@x"
		SettingLoader:"@y"
		SettingLoader:"@defaultScale"
		SettingLoader:"@bgm"
		SettingLoader:"@voiceVolume"
		SettingLoader:"@backVoiceVolume"
		SettingLoader:"@bgmVolume"
		SettingLoader:"@seVolume"

		ThumbnailLoader:"@thumbnail"
		
## imageLocations.xml の仕様
	
	<location name="imageName" x="000" y="000 />
	
シナリオディレクトリの texts に配置する。画像描画時の位置を指定できる。画面左上が原点です。

## configuration.xml の仕様

	/commonResource/texts/configuration.xml に記述。
	プログラムから自動生成されるため編集の必要はないので仕様の確認用。

	Configuration:"@selectionIndex"
	Configuration:"@fullScreenMode"

全てのファイルは ActionScript3.0 で使用する場合は

	<root> ... </root>

で挟む。