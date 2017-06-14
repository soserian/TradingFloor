package bgs.game.model
{
	import flash.events.EventDispatcher;

	public class OptionModel extends EventDispatcher
	{
		static private var _optionModel:OptionModel;
		private var _sndState;
		public function OptionModel()
		{
		}
		static public function getInstance():OptionModel
		{
			if (!_optionModel)
			{
				_optionModel = new OptionModel;
			}
			
			return _optionModel;
		}
		
		public function get sndState():Boolean
		{
			return _sndState;
		}
		public function set sndState(state:Boolean):void
		{
			_sndState = state;
		}
	}
}