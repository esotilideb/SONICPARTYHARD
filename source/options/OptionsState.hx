package options;

import backend.StageData;

class OptionsState extends MusicBeatSubstate
{
	var options:Array<String> = ['Controls', 'Graphics', 'Visuals and UI', 'Gameplay'];
	private var grpOptions:FlxTypedGroup<FlxText>;
	private static var curSelected:Int = 0;
	public static var menuBG:FlxSprite;
	public static var onPlayState:Bool = false;
	var canAngle:Bool = true;

	function openSelectedSubstate(label:String) {
		switch(label) {
			case 'Controls':
				openSubState(new options.ControlsSubState());
			case 'Graphics':
				openSubState(new options.GraphicsSettingsSubState());
			//case 'Note offset': //not used
			//	MusicBeatState.switchState(new options.NoteOffsetState());
			case 'Visuals and UI':
				openSubState(new options.VisualsUISubState());
			case 'Gameplay':
				openSubState(new options.GameplaySettingsSubState());
		}
	}

	override function create() {

		var blackScreen = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
		blackScreen.alpha = 0.7;
		add(blackScreen);

		grpOptions = new FlxTypedGroup<FlxText>();
		add(grpOptions);

		for (i in 0...options.length)
		{
			var optionText = new FlxText(0, 0, 0, "" + options[i], 24);
			optionText.setFormat(Paths.font("retro.ttf"), 50, FlxColor.WHITE, CENTER);
			optionText.screenCenter();
			optionText.ID = i;
			optionText.y += (100 * (i - (options.length / 2))) + 50;
			grpOptions.add(optionText);
		}

		changeSelection();
		ClientPrefs.saveSettings();

		super.create();
	}

	override function closeSubState() {
		super.closeSubState();
		ClientPrefs.saveSettings();
	}

	override function update(elapsed:Float) {
		super.update(elapsed);

		if (controls.UI_UP_P) {
			changeSelection(-1);
		}
		if (controls.UI_DOWN_P) {
			changeSelection(1);
		}

		if (controls.BACK) {
			FlxTween.cancelTweensOf(grpOptions.members);
			canAngle = false;
			if(onPlayState)
			{
				new FlxTimer().start(0.012, function(tmr:FlxTimer){	LoadingState.loadAndSwitchState(new PlayState());	}, 0);
				StageData.loadDirectory(PlayState.SONG);
				FlxG.sound.music.volume = 0;

			}
			else new FlxTimer().start(0.012, function(tmr:FlxTimer){close();}, 0);
		}
		else if (controls.ACCEPT) openSelectedSubstate(options[curSelected]);
	}
	
	var cTweenMisterioso:FlxTween;
	function changeSelection(change:Int = 0) {

		curSelected = FlxMath.wrap(curSelected + change, 0, options.length-1);

		for (i=>item in grpOptions.members) {
			FlxTween.tween(item, {"scale.x": 1, "scale.y": 1}, 0.5, {ease: FlxEase.expoOut});
			item.alpha = 0.4;
			if (item.ID == curSelected) {
				grpOptions.members[curSelected].alpha = 1;
				grpOptions.members[curSelected].angle = 0;

				FlxTween.cancelTweensOf(grpOptions.members[curSelected]);
				FlxTween.tween(grpOptions.members[curSelected], {"scale.x": 1.25, "scale.y": 1.25}, 0.5, {ease: FlxEase.expoOut});	
			}
		}
		FlxG.sound.play(Paths.sound('scrollMenu'));
	}

	override function destroy()
	{
		ClientPrefs.loadPrefs();
		super.destroy();
	}
}