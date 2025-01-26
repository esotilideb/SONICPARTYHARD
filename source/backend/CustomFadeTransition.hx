package backend;

import flixel.util.FlxGradient;

class CustomFadeTransition extends MusicBeatSubstate {
	public static var finishCallback:Void->Void;
	var isTransIn:Bool = false;
	var transBlack:FlxSprite;
	var transGradient:FlxSprite;

	var duration:Float;
	public function new(duration:Float, isTransIn:Bool)
	{
		this.duration = duration;
		this.isTransIn = isTransIn;
		super();
	}

	override function create()
	{
		cameras = [FlxG.cameras.list[FlxG.cameras.list.length-1]];
		FlxG.camera.fade(FlxColor.BLACK, duration, isTransIn, function() {
			close();
			if(finishCallback != null) finishCallback();
			finishCallback = null;
        });

		trace("transition duration: " + duration);
		super.create();
	}

	override function update(elapsed:Float) {
		super.update(elapsed);

		if(FlxG.camera.color == FlxColor.BLACK)
		{
			close();
			if(finishCallback != null) finishCallback();
			finishCallback = null;
		}
	}
}