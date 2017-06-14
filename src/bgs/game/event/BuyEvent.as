package bgs.game.event
{
	import flash.events.Event;
	
	public class BuyEvent extends Event
	{
		static public const BUY_SELECT_COMPLETE:String = "buyCom";
		static public const BUY_RULE_CLOSE:String = "buyClose";
		public var data:*; 
		public function BuyEvent(type:String, $data:* = null)
		{
			super(type);
			
			data = $data;
		}
		
		override public function clone():Event
		{
			return new BuyEvent(type, data);
		}
	}
}