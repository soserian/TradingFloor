package bgs.game.model
{
	import flash.events.EventDispatcher;
	
	import bgs.game.vo.Tile;

	public class StockTileModel extends EventDispatcher
	{
		private var _tileArr:Vector.<Tile>;
		private var _selIndex:uint = 0;
		static private var _stockTileModel:StockTileModel;
		public function StockTileModel()
		{
		}
		static public function getInstance():StockTileModel
		{
			if (!_stockTileModel)
			{
				_stockTileModel = new StockTileModel;
			}
			
			return _stockTileModel;
		}
		
		public function get selIndex():uint
		{
			return _selIndex;
		}
		
		public function set selIndex(index:uint):void
		{
			_selIndex = index;
		}
		public function get currentTile():Tile
		{
			return _tileArr[_selIndex];
		}
		public function get nextTile():Tile
		{
			return _tileArr[_selIndex + 1];
		}
		public function get tileSeqArr():Vector.<Tile>
		{
			return _tileArr;
		}
		public function set tileSeqArr(arr:Vector.<Tile>):void
		{
			_tileArr = arr;
		}
	}
}