package bgs.game.define
{
	public class State
	{
		static public const BUY_STATE:String = "buyState";
		static public const SELL_STATE:String = "sellState";
		static public const ITEM_GET_STATE:String = "itemGetState";
		static public const ITEM_USE_STATE:String = "itemUseState";
		static public const STOCK_CHANGE_STATE:String = "stockChangeState";
		static public const STOCK_TILE_CHANGE_STATE:String = "stockTileChangeState";
		
		static public const STATE_SQUENCE:Vector.<String> = new <String>[
			State.BUY_STATE,
			State.SELL_STATE,
			State.ITEM_GET_STATE,
			State.STOCK_CHANGE_STATE,
			State.STOCK_TILE_CHANGE_STATE
		];
	}
}