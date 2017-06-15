package bgs.game.model
{
	import flash.events.EventDispatcher;
	
	import bgs.game.event.UserEvent;

	public class UserModel extends EventDispatcher
	{
		private var _cash:int;
		private var _eventCards:Vector.<uint>;
		private var _stockCards:Vector.<uint>;
		private var _userId:uint;
		static private var _userModel:UserModel;
		public function UserModel(userID:uint)
		{
			_userId = userID;
		}
		static public function getInstance():UserModel
		{
			if (!_userModel){
				_userModel = new UserModel(1);
			}
			
			return _userModel;
		}
		public function get id():uint
		{
			return _userId;
		}
		public function get cash():int
		{
			return _cash;
		}
		public function set cash($cash:int):void
		{
			_cash = $cash;
			dispatchEvent(new UserEvent(UserEvent.CHANGE_CASH, _cash));
		}
		public function get eventCards():Vector.<uint>
		{
			return _eventCards;
		}
		public function set eventCards($eventCards:Vector.<uint>):void
		{
			_eventCards = $eventCards;
		}
		public function get stockCards():Vector.<uint>
		{
			return _stockCards;
		}
		public function set stockCards($stockCards):void
		{
			_stockCards = $stockCards;
		}
	}
}