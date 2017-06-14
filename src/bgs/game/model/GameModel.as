package bgs.game.model
{
	import flash.events.EventDispatcher;
	
	import bgs.game.event.DiceEvent;

	public class GameModel extends EventDispatcher
	{	
		private var _state:uint = 0;
		private var _round:uint = 0;
		private var _dice:uint = 0;
		private var _isFirst:Boolean = true;
		static private var _gameModel:GameModel;
		
		public function GameModel()
		{
		}
		static public function getInstance():GameModel
		{
			if (!_gameModel)
			{
				_gameModel = new GameModel;
			}
			
			return _gameModel;
		}
		public function get isFirst():Boolean
		{
			return _isFirst;
		}
		public function set isFirst(first:Boolean):void
		{
			_isFirst = first;
		}
		public function get round():uint
		{
			return _round;
		}
		public function set round(r:uint):void
		{
			_round = r;
		}
		public function get state():uint
		{
			return _state;
		}
		public function set state(s:uint):void
		{
			_state = s;
		}
		
		public function get dice():uint
		{
			return _dice;
		}
		public function set dice($dice:uint):void
		{
			_dice = $dice;
			dispatchEvent(new DiceEvent(DiceEvent.DICE_COM, _dice));
		}
	}
}