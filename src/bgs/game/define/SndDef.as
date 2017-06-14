package bgs.game.define
{
	public class SndDef
	{
		static public const SND1_ID:uint = 1;
		static public var MUTE:Boolean = false;
		public function SndDef()
		{
		}
		static public function play(id:uint, repeat:uint):void
		{
			if (MUTE == false){
				SndDef["SND" + id].play(repeat);				
			}
		}
		static private const SND1:Snd1 = new Snd1;
	}
}