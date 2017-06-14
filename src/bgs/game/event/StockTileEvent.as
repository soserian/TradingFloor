package bgs.game.event
{
	import flash.events.Event;
	
	public class StockTileEvent extends Event
	{
		static public const TILE_CHANGE:String = "tileChange";
		public function StockTileEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}