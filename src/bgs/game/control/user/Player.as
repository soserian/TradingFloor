package bgs.game.control.user
{
	import bgs.game.define.Players;
	import bgs.game.model.StockModel;
	import bgs.game.model.UserModel;

	public class Player implements IGamer
	{
		static private var _player:Player;
//		private var _card:Vector.<uint>;
//		private var _eCard:Vector.<uint>;
//		private var _money:uint;
		private var _tempList:Vector.<uint>;
		private var _model:UserModel = UserModel.getInstance();
		
		public function Player()
		{
			_model.cash = Players.DEFUALT_MONEY;
			_model.stockCards = Players.DEFUALT_STOCK_LIST.slice(0);
		}
		static public function getInstance():Player
		{
			if (!_player){
				_player = new Player;
			}
			
			return _player;
		}
		public function init():void
		{
			_model.stockCards = Players.DEFUALT_STOCK_LIST.slice(0);
			_model.cash = Players.DEFUALT_MONEY;
			_model.eventCards = new Vector.<uint>;
		}
//		public function sellStock(arr:Vector.<uint>):void
//		{
//			_tempList = arr.slice(0);
//		}
		public function acceptSellStock(list:Vector.<uint>):void
		{
			var tm:uint;
			for (var i:uint = 0; i < list.length; i++)
			{
				tm = list[i];
				if (tm == 0){
					continue;
				}
				_model.stockCards[i] -= list[i];
				_model.cash += StockModel.getInstance().stock[i] * list[i];
			}
		}
		
//		public function buyStock(arr:Vector.<uint>):void
//		{
//			_tempList = arr.slice(0);
//		}
		public function acceptBuyStock(list:Vector.<uint>):void
		{
			trace(list);
			var tm:uint;
			for (var i:uint = 0; i < list.length; i++)
			{
				tm = list[i];
				if (tm == 0){
					continue;
				}
				_model.stockCards[i] += list[i];
				_model.cash -= StockModel.getInstance().stock[i] * list[i];
			}
		}
	}
}