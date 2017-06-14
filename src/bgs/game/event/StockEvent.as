package bgs.game.event
{
	import flash.events.Event;
	
	public class StockEvent extends Event
	{
		static public const CHANGE:String = "change";
		static public const CHANGE_ANI_COM:String = "changeAniCom";
		
		public var data:*;
		public function StockEvent(type:String, data:* = null)
		{
			super(type, data);
		}
		override public function clone():Event
		{
			return new BuyEvent(type, data);
		}
	}
}