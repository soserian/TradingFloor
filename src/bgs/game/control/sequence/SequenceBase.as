package bgs.game.control.sequence
{
	import flash.events.EventDispatcher;
	
	import bgs.game.model.GameModel;
	
	public class SequenceBase extends EventDispatcher implements IGameControl
	{
		protected var _main:Main;
		protected var _step:uint;
		protected var _isFirst:Boolean;
		public function SequenceBase(main:Main)
		{
			_main = main;
		}
		
		public function start():void
		{
			_step = 0;
			_isFirst = GameModel.getInstance().isFirst;
			_setStep();
			
		}
		
		protected function _nextStep():void
		{
			_step++;
			_setStep();
		}
		
		protected function _setStep():void{}
	}
}