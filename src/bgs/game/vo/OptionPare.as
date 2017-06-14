package bgs.game.vo
{
	import flash.display.MovieClip;

	public class OptionPare
	{
		private var _btn1:MovieClip;
		private var _btn2:MovieClip;
		public function OptionPare($btn1:MovieClip, $btn2:MovieClip)
		{
			_btn1 = $btn1;
			_btn2 = $btn2;
		}
		
		public function get btn1():MovieClip
		{
			return _btn1;
		}
		public function get btn2():MovieClip
		{
			return _btn2;
		}
	}
}