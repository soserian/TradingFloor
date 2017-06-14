package bgs.game.control.game
{
	import bgs.game.define.Stock;
	import bgs.game.event.DiceEvent;
	import bgs.game.model.GameModel;
	import bgs.game.model.StockModel;
	import bgs.game.model.StockTileModel;
	import bgs.game.vo.Tile;

	public class DiceControl
	{
		private var _stockModel:StockModel;
		private var _stockTileModel:StockTileModel;
		private var _gameModel:GameModel;
		
		public function DiceControl()
		{
			_stockModel = StockModel.getInstance();
			_stockTileModel = StockTileModel.getInstance();
			_gameModel = GameModel.getInstance();
			_attachEvent();
		}
		
		private function _attachEvent():void
		{
			_gameModel.addEventListener(DiceEvent.DICE_COM, _diceCom);
		}
		
		private function _diceCom(e:DiceEvent):void
		{
			var tile:Tile = _stockTileModel.currentTile;
			var idx:uint = (_gameModel.dice - 1) / 2 | 0;
			var divArr:Vector.<uint> = _stockModel.dividend;
			var stockArr:Vector.<uint> = _stockModel.stock;
			var tmObj:Object;
			
			for (var i:uint = 0; i < 4; i++){
				tmObj = _alignStock(i, tile.getCardInfo(i)[idx]);
				
				divArr[i] += tmObj.dividend;
				stockArr[i] += tmObj.stock;
			}
			
			_stockModel.dividend = divArr;
			_stockModel.stock = stockArr;
		}
		private function _alignStock(index:uint, tileNum:int):Object
		{
			var divide:uint = 0;
			var stockNum:int = tileNum;
			if (tileNum > 2){
				divide = 1;
				stockNum = tileNum - 3;
			}
			
			return {
				dividend: divide,
				stock: stockNum * Stock.STOCK_MOVE_STEP[index]
			};
		}
	}
}