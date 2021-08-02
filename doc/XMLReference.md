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
			"slide"
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

	<bgm>
		BGMElementConverter:"@fileName"
		BGMElementConverter:"@number"
		BGMElementConverter:"@volume"

	<backVoice>
		BackVoiceElementConverter:"@characterChannel"
		BackVoiceElementConverter:"@names"
		BackVoiceElementConverter:"@volume"

	<draw>
		a-c までの属性内にはファイル名を入力する
		DrawElementConverter:"@a"
		DrawElementConverter:"@b"
		DrawElementConverter:"@c"
		DrawElementConverter:"@depth"
		DrawElementConverter:"@target"

	<image>
		a-c までの属性内にはファイル名を入力する
		ImageElementConverter:"@a"
		ImageElementConverter:"@backgroundColor"
			8 桁の 16 進数(ARGB)で指定する。 ex : <image backgroundColor="0xffffffff" />

		ImageElementConverter:"@b"
		ImageElementConverter:"@c"
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

## configuration.xml の仕様

	/commonResource/texts/configuration.xml に記述。
	プログラムから自動生成されるため編集の必要はないので仕様の確認用。

	Configuration:"@selectionIndex"
	Configuration:"@fullScreenMode"

全てのファイルは ActionScript3.0 で使用する場合は

	<root> ... </root>

で挟む。