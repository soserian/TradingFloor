package bgs.game.event
{
	import flash.events.Event;
	
	public class DiceEvent extends Event
	{
		static public const DICE_COM:String = "diceCom";
		static public const DICE_VIEW_COM:String = "diceViewCom";
		public var data:*; 
		public function DiceEvent(type:String, $data:* = null)
		{
			super(type);
			
			data = $data;
		}
		
		override public function clone():Event
		{
			return new DiceEvent(type, data);
		}
	}
}