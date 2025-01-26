package states;

import backend.WeekData;
import backend.Highscore;

import flixel.input.keyboard.FlxKey;
import flixel.addons.transition.FlxTransitionableState;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.graphics.frames.FlxFrame;
import flixel.group.FlxGroup;
import flixel.input.gamepad.FlxGamepad;
import haxe.Json;

import openfl.Assets;
import openfl.display.Bitmap;
import openfl.display.BitmapData;
import options.OptionsState;
import backend.Song;

import haxe.Http;


class TitleState extends MusicBeatState
{ 	//GAME STUFF
	public static var muteKeys:Array<FlxKey> = [FlxKey.ZERO];
	public static var volumeDownKeys:Array<FlxKey> = [FlxKey.NUMPADMINUS, FlxKey.MINUS];
	public static var volumeUpKeys:Array<FlxKey> = [FlxKey.NUMPADPLUS, FlxKey.PLUS];

	public static var initialized:Bool = false;

  	//Actual Menu Shit

	var logo:FlxSprite;
	var text:FlxText;
	var menuItems:FlxTypedGroup<FlxSprite>;
	var optionShit:Array<String> = ['start','options'];
	public static var curSelected:Int = 0;

	override public function create():Void
	{
		Paths.clearStoredMemory();

		#if LUA_ALLOWED
		Mods.pushGlobalMods();
		#end
		Mods.loadTopMod();

		FlxG.fixedTimestep = false;
		FlxG.game.focusLostFramerate = 60;
		FlxG.keys.preventDefaultKeys = [TAB];

		super.create();

		FlxG.save.bind('funkin', CoolUtil.getSavePath());
		ClientPrefs.loadPrefs();
		Highscore.load();

		if(!initialized)
		{
			if(FlxG.save.data != null && FlxG.save.data.fullscreen)
			{
				FlxG.fullscreen = FlxG.save.data.fullscreen;
				//trace('LOADED FULLSCREEN SETTING!!');
			}
			persistentUpdate = true;
			persistentDraw = true;
		}

		FlxG.mouse.useSystemCursor = true;

        logo = new FlxSprite(0, -350).loadGraphic(Paths.image('mainmenu/Ultrasonic1'));
		logo.antialiasing = ClientPrefs.data.antialiasing;
		logo.scale.set(0.2, 0.2);
		logo.screenCenter(X);
		add(logo);

		var esotilin = new FlxSprite(0, 425);
		esotilin.frames = Paths.getSparrowAtlas('mainmenu/dance');
		esotilin.screenCenter(X);
		esotilin.scale.set(1.5,1.5);
		esotilin.antialiasing = false;
		esotilin.animation.addByPrefix('dance', 'dance', 24, true);			esotilin.animation.play('dance');
		add(esotilin);	

		text = new FlxText(FlxG.width, 300, 0, "DANCE DANCE DANCE DANCE DANCE DANCE DANCE DANCE DANCE DANCE DANCE DANCE DANCE DANCE", 42);
		text.setFormat(Paths.font("retro.ttf"), 42, FlxColor.YELLOW, RIGHT);
		add(text);

		var creds = new FlxText(950, 900, 0, "supersonic2002 - 2008", 24);
		creds.setFormat(Paths.font("retro.ttf"), 24, FlxColor.YELLOW, RIGHT);
		add(creds);

		menuItems = new FlxTypedGroup<FlxSprite>();
		add(menuItems);

		for (i in 0...optionShit.length)
			{
				var menuItem = new FlxSprite(0, 700 + (i * 90)).loadGraphic(Paths.image('mainmenu/' + optionShit[i]));
				menuItem.antialiasing = ClientPrefs.data.antialiasing;
				menuItem.scale.set(0.3,0.3);
				menuItem.ID = i;
				menuItems.add(menuItem);
				var scr:Float = (optionShit.length - 4) * 0.135;
				if (optionShit.length < 6)
					scr = 0;
				menuItem.scrollFactor.set(0, scr);
				menuItem.updateHitbox();
				menuItem.screenCenter(X);

			}
		
		#if CHARTING
		MusicBeatState.switchState(new ChartingState());
		#else
			FlxG.sound.playMusic(Paths.music('conker bad fur day rock solid loop'), 1);
		#end
	}

	var transitioning:Bool = false;
	var selectedSomethin:Bool = false;
	var usingMouse:Bool = false;
	override function update(elapsed:Float)
	{		
		text.x += elapsed * 280; 
		if (text.x > 50) text.x = -525;

		if (FlxG.sound.music != null)
			Conductor.songPosition = FlxG.sound.music.time;
		// FlxG.watch.addQuick('amp', FlxG.sound.music.amplitude);

		var peggle:Bool;
		var gamepad:FlxGamepad = FlxG.gamepads.lastActive;

		if (gamepad != null)
		{
			if (gamepad.justPressed.START)
				peggle = true;

			#if switch
			if (gamepad.justPressed.B)
				peggle = true;
			#end
		}

		if (!selectedSomethin)
		{
			menuItems.forEach(function(spr:FlxSprite)
				{
					if (usingMouse)
					{
						if (!FlxG.mouse.overlaps(spr)) 
							spr.color = FlxColor.WHITE;
					}
		
					if (FlxG.mouse.overlaps(spr))
					{
							curSelected = spr.ID;
							trace(curSelected);
							usingMouse = true;
							spr.color = FlxColor.YELLOW;
		
						if (FlxG.mouse.pressed) selectSomething(); //startDialogueToSong();
					}
					else	
						if (usingMouse)	{ 
							spr.color = FlxColor.WHITE;
						}
	
					spr.updateHitbox();
				});
		}

		super.update(elapsed);
	}

	function selectSomething()
		{

			menuItems.forEach(function(spr:FlxSprite)
			{
					new FlxTimer().start(0.1, function(tmr:FlxTimer)
					{
						switch (optionShit[curSelected])
						{
								case 'start':
									PlayState.storyPlaylist = ['ultra-sonic-blast'];
									PlayState.isStoryMode = true;
									PlayState.campaignScore = 0;
									PlayState.campaignMisses = 0;
									PlayState.SONG = Song.loadFromJson(StringTools.replace(PlayState.storyPlaylist[0]," ", "-").toLowerCase(), StringTools.replace(PlayState.storyPlaylist[0]," ", "-").toLowerCase());        
									PlayState.storyDifficulty = 1;
									selectedSomethin = true;
									new FlxTimer().start(.1, function(tmr:FlxTimer)
										{
											LoadingState.loadAndSwitchState(new PlayState(), true);
										});
									
								case 'options':
									//MusicBeatState.switchState(new OptionsState());
									openSubState(new OptionsState());
									persistentUpdate = false;
									persistentDraw = true;
									OptionsState.onPlayState = false;
									if (PlayState.SONG != null)
									{
										PlayState.SONG.arrowSkin = null;
										PlayState.SONG.splashSkin = null;
										PlayState.stageUI = 'normal';
									}
						}
					});
			});
		}
}