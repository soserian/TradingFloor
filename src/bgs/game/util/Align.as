package bgs.game.util
{
	import flash.text.TextField;

	public class Align
	{
		public function Align()
		{
		}
		
		static public function textVAlign(field:TextField, startY:Number, height:Number):void
		{
			field.y = startY + (height - field.height) / 2;
		}
	}
}