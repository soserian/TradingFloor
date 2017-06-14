package bgs.game.util
{
	import flash.display.MovieClip;
	import flash.events.Event;

	public class FrameAnimation
	{
		public function FrameAnimation()
		{
		}
		
		static public function reqFrameAni(mc:MovieClip, callback:Function, reverse:Boolean = false):void{
			mc.addEventListener(Event.ENTER_FRAME, function(e:Event):void
			{
				var tmMc:MovieClip = e.currentTarget as MovieClip;
				if (reverse == true){
					tmMc.prevFrame();
				}else{
					tmMc.nextFrame();
				}
				if (tmMc.currentFrame == (reverse == true ? 1 : tmMc.totalFrames)){
					tmMc.removeEventListener(Event.ENTER_FRAME, arguments.callee);
					callback();
				}
			});
		}
	}
}