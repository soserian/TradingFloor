package bgs.game.control.user
{
	import com.greensock.TweenMax;
	
	import bgs.game.define.Players;
	import bgs.game.event.UserEvent;
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
		private var _main:Main;
		
		public function Player(main:Main)
		{
			_main = main;
			_model.cash = Players.DEFUALT_MONEY;
			_model.stockCards = Players.DEFUALT_STOCK_LIST.slice(0);
		}
		public function init():void
		{
			_main.money_text.visible = true;
			_model.addEventListener(UserEvent.CHANGE_CASH, _handlerChangeCash);
			
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
				_setCard(i);
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
				_setCard(i);
				_model.cash -= StockModel.getInstance().stock[i] * list[i];
			}
		}
		private function _setCard(index:uint):void
		{
			var i:uint = index;
			if (_model.stockCards[i] == 0) {
				_main.userCard["cardNum" + (i + 1)].visible = false;
				_main.userCard["card" + (i + 1)].visible = false;
			}else{
				_main.userCard["cardNum" + (i + 1)].visible = true;
				_main.userCard["card" + (i + 1)].visible = true;
				_main.userCard["cardNum" + (i + 1)].gotoAndStop(_model.stockCards[i]);
			}
		}
		protected function _handlerChangeCash(e:UserEvent):void
		{
			var obj:Object = {num:0};
			TweenMax.to(obj, .5, {num: int(e.data), onUpdate: _aniMoney, onUpdateParams: [obj]});
		}
		private function _generateMoney(num:int):String
		{
			var str:String = String(num);
			var returnStr:String = "";
			while(true){
				if (str.length > 3){
					returnStr = "," + str.substr(str.length - 3);
					str = str.substr(0, str.length - 3);
				}else{
					returnStr = str + returnStr;
					break;
				}
			}
			return returnStr;
		}
		private function _aniMoney(obj:Object):void
		{
			var num:int = obj.num;
			_main.money_text.text = _generateMoney(num);
		}
	}
}