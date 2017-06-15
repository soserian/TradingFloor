package bgs.game.model
{
	import flash.events.EventDispatcher;
	
	import bgs.game.control.user.IGamer;

	public class PlayerModel extends EventDispatcher
	{
		// 플레이어들 정보가 저장됨
		private var _players:Vector.<IGamer> = new Vector.<IGamer>;
		private var _cashes:Vector.<uint>;
		private var _blocks:Array;
		private var _stockCards:Array;
		private var _eventCards:Array;
		static private var _playerModel:PlayerModel;
		public function PlayerModel()
		{
		}
		static public function getInstance():PlayerModel
		{
			if (!_playerModel){
				_playerModel = new PlayerModel;
			}
			
			return _playerModel;
		}
		public function get cash():Vector.<uint>
		{
			return _cashes;
		}
		public function set cash($cash:Vector.<uint>):void
		{
			_cashes = $cash;
		}
		public function get stockCards():Array
		{
			return _stockCards;
		}
		public function set stockCards($stockCards:Array):void
		{
			_stockCards = $stockCards;
		}
		
		public function get eventCards():Array
		{
			return _eventCards;
		}
		public function set eventCards($eventCards:Array):void
		{
			_eventCards = $eventCards;
		}
		
	}
}