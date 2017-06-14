package bgs.game.control.user
{
	import bgs.game.define.Players;
	import bgs.game.model.PlayerModel;
	import bgs.game.model.StockModel;
	import bgs.game.vo.StockChangeVO;

	public class PlayerControl
	{
		static private var _playerControl:PlayerControl;
		
		private var _user:Player;
		private var _userTemp:Vector.<uint>;
		private var _pcTemp:Array;
		
		public function PlayerControl()
		{
			var playerModel:PlayerModel = PlayerModel.getInstance();
			
			playerModel.stockCards = [new <uint>[2, 2, 2, 2], 
				new <uint>[2, 2, 2, 2], new <uint>[2, 2, 2, 2]];
			playerModel.cash = new <uint>[Players.DEFUALT_MONEY,Players.DEFUALT_MONEY,Players.DEFUALT_MONEY];
			
			_user = new Player();
			
		}
		
		static public function getInstance():PlayerControl
		{
			if (!_playerControl){
				_playerControl = new PlayerControl;
			}
			
			return _playerControl;
		}
		/**
		 * 현재는 PC의 동작을 이 곳에 포함하지만 나중에 PC객체에 빼고 관리하도록 수정한다.
		 */
		public function sell(userSel:Vector.<uint>):StockChangeVO
		{
			var sellCard1:uint;
			var sellCard2:uint;
			var stockModel:StockModel = StockModel.getInstance();
			var playerModel:PlayerModel = PlayerModel.getInstance();
			var add:uint, tm:uint;
			var defaultArr:Vector.<uint> = new <uint>[0, 0, 0, 0];
			var addStockStep:Vector.<uint>;
			var tmArr:Vector.<uint>;
			
			_userTemp = userSel.slice();
			_pcTemp = [];
			
			for (var i:uint = 0; i < playerModel.stockCards.length; i++)
			{
				_pcTemp.push(new <uint>[0, 0, 0, 0]);
				sellCard1 = (Math.random() * 4) | 0;
				sellCard2 = (Math.random() * 4) | 0;
				_pcTemp[i][sellCard1]++;
				_pcTemp[i][sellCard2]++;
				
				defaultArr[sellCard1]++;
				defaultArr[sellCard2]++;
			}
			
			addStockStep = new Vector.<uint>;
			tmArr = new Vector.<uint>;
			for (i = 0; i < defaultArr.length; i++){
				tm = _userTemp[i] + defaultArr[i];
				tmArr.push(tm);
				add = 0;
				if (tm >= 5){
					add = 3;
				}else if(tm == 4){
					add = 2;
				}else if(tm == 3){
					add = 1;
				}
				addStockStep.push(add);
			}
			return new StockChangeVO(tmArr, addStockStep);
		}
		
		public function buy(userSel:Vector.<uint>):StockChangeVO
		{
			var buyCard1:uint;
			var buyCard2:uint;
			var stockModel:StockModel = StockModel.getInstance();
			var playerModel:PlayerModel = PlayerModel.getInstance();
			var add:uint, tm:uint;
			var defaultArr:Vector.<uint> = new <uint>[0, 0, 0, 0];
			var addStockStep:Vector.<uint>;
			var tmArr:Vector.<uint>;
			_userTemp = userSel.slice(0);
			
			_pcTemp = [];
			for (var i:uint = 0; i < playerModel.stockCards.length; i++)
			{
				_pcTemp.push(new <uint>[0, 0, 0, 0]);
				buyCard1 = (Math.random() * 4) | 0;
				buyCard2 = (Math.random() * 4) | 0;
				
				_pcTemp[i][buyCard1]++;
				_pcTemp[i][buyCard2]++;
				
				defaultArr[buyCard1]++;
				defaultArr[buyCard2]++;
			}
			
//			Player.getInstance().buyStock(_selectArr);
			addStockStep = new Vector.<uint>;
			tmArr = new Vector.<uint>;
			for (i = 0; i < defaultArr.length; i++){
				tm = _userTemp[i] + defaultArr[i];
				tmArr.push(tm);
				add = 0;
				if (tm >= 5){
					add = 3;
				}else if(tm == 4){
					add = 2;
				}else if(tm == 3){
					add = 1;
				}
				addStockStep.push(add);
			}
			return new StockChangeVO(tmArr, addStockStep);
		}
		public function acceptBuyStock():void
		{
			var stockModel:StockModel = StockModel.getInstance();
			var playerModel:PlayerModel = PlayerModel.getInstance();
			var tm:uint;
			for (var i:uint = 0; i < _pcTemp.length; i++)
			{
				for (var j:uint = 0; j < _pcTemp[i].length; j++)
				{
					tm = _pcTemp[i][j];
					if (tm == 0){
						continue;
					}
					
					playerModel.stockCards[i][j] += tm;
					playerModel.cash[i] -= stockModel.stock[j] * tm;
//					_cards[i][j] += tm;
//					
//					_money[i] -= stockModel.stock[j] * tm;
				}
			}
			
			_user.acceptBuyStock(_userTemp);
			
			_userTemp = null;
			_pcTemp = null;
		}
		public function acceptSellStock():void
		{
			var stockModel:StockModel = StockModel.getInstance();
			var playerModel:PlayerModel = PlayerModel.getInstance();
			var tm:uint;
			for (var i:uint = 0; i < _pcTemp.length; i++)
			{
				for (var j:uint = 0; j < _pcTemp[i].length; j++)
				{
					tm = _pcTemp[i][j];
					if (tm == 0){
						continue;
					}
					playerModel.stockCards[i][j] -= tm;
					playerModel.cash[i] += stockModel.stock[j] * tm;
//					_cards[i][j] -= tm;
//					_money[i] += stockModel.stock[j] * tm;
				}
			}
			
			_user.acceptSellStock(_userTemp);
			
			_userTemp = null;
			_pcTemp = null;
		}
	}
}