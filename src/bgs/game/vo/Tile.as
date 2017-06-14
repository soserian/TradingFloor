package bgs.game.vo
{
	import bgs.game.define.StockTiles;

	public class Tile
	{
		private var _index:uint;
		private var _tileInfo:Array;
		public function Tile(tileNum:uint)
		{
			_index = tileNum;
			_tileInfo = [
				StockTiles["CARD_" + (_index + 1) + "_1"],
				StockTiles["CARD_" + (_index + 1) + "_2"],
				StockTiles["CARD_" + (_index + 1) + "_3"],
				StockTiles["CARD_" + (_index + 1) + "_4"],
			];
		}
		
		public function get index():uint
		{
			return _index;
		}
		public function getCardInfo(index:uint):Vector.<int>
		{
			return _tileInfo[index];
		}
	}
}