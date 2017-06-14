package bgs.game.control.user{
	import bgs.game.define.Players;
	import bgs.game.model.StockModel;

	public class PC implements IGamer
	{
		private var _cards:Array;
		private var _tempArr:Array;
		private var _money:Array;
		private var _eCards:Array;
		
		static private var _pc:PC;
		public function PC()
		{
		}
		static public function getInstance():PC
		{
			if (!_pc){
				_pc = new PC;
			}
			
			return _pc;
		}
		public function init():void
		{
			_cards = [
				Players.DEFUALT_STOCK_LIST.slice(0),
				Players.DEFUALT_STOCK_LIST.slice(0),
				Players.DEFUALT_STOCK_LIST.slice(0)
			];
			_money = [
				Players.DEFUALT_MONEY, 
				Players.DEFUALT_MONEY, 
				Players.DEFUALT_MONEY
			];
			
			_eCards = [[], [], []];
		}
		
		public function autoSell():Vector.<uint>
		{
			var buyCard1:uint;
			var buyCard2:uint;
			var stockModel:StockModel = StockModel.getInstance();
			var defaultArr:Vector.<uint> = new <uint>[0, 0, 0, 0];
			_tempArr = [];
			for (var i:uint = 0; i < _cards.length; i++)
			{
				_tempArr.push([0, 0, 0, 0]);
				buyCard1 = (Math.random() * 4) | 0;
				buyCard2 = (Math.random() * 4) | 0;
				_tempArr[i][buyCard1]++;
				_tempArr[i][buyCard2]++;
				
				defaultArr[buyCard1]++;
				defaultArr[buyCard2]++;
			}
			
			return defaultArr;
		}
		
		public function autoBuy():Vector.<uint>
		{
			var buyCard1:uint;
			var buyCard2:uint;
			var stockModel:StockModel = StockModel.getInstance();
			var defaultArr:Vector.<uint> = new <uint>[0, 0, 0, 0];
			_tempArr = [];
			for (var i:uint = 0; i < _cards.length; i++)
			{
				_tempArr.push([0, 0, 0, 0]);
				buyCard1 = (Math.random() * 4) | 0;
				buyCard2 = (Math.random() * 4) | 0;
				_tempArr[i][buyCard1]++;
				_tempArr[i][buyCard2]++;
				
				defaultArr[buyCard1]++;
				defaultArr[buyCard2]++;
			}
			
			return defaultArr;
		}
		public function acceptBuyStock():void
		{
			var stockModel:StockModel = StockModel.getInstance();
			var tm:uint;
			for (var i:uint = 0; i < _tempArr.length; i++)
			{
				for (var j:uint = 0; j < _tempArr[i].length; j++)
				{
					tm = _tempArr[i][j];
					if (tm == 0){
						continue;
					}
					_cards[i][j] += tm;
					
					_money[i] -= stockModel.stock[j] * tm;
				}
				
			}
		}
		public function acceptSellStock():void
		{
			var stockModel:StockModel = StockModel.getInstance();
			var tm:uint;
			for (var i:uint = 0; i < _tempArr.length; i++)
			{
				for (var j:uint = 0; j < _tempArr[i].length; j++)
				{
					tm = _tempArr[i][j];
					if (tm == 0){
						continue;
					}
					_cards[i][j] -= tm;
					
					_money[i] += stockModel.stock[j] * tm;
				}
				
			}
		}
	}
}