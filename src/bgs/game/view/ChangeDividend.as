package bgs.game.view
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	import bgs.game.model.StockModel;
	import bgs.game.util.FrameAnimation;

	public class ChangeDividend extends EventDispatcher
	{
		private var _main:Main;
		private var _stockModel:StockModel;
		private var _allocComCnt:uint = 0;
		private var _allocTotal:uint;
		public function ChangeDividend(main:Main)
		{
			_main = main;
		}
		
		public function init():void
		{
			_stockModel = StockModel.getInstance();
		}
		public function changeAni():void
		{
			var dividend:Vector.<uint>;
			var num:uint;
			dividend = _stockModel.dividend.slice(0);
			
			trace("dividend = ", dividend);
			_allocComCnt = 0;
			_allocTotal = 0;
			
			for (var i:uint = 0; i < dividend.length; i++){
				num = dividend[i];
				for (var j:uint = 0; j < num; j++){
					_allocTotal++;
					FrameAnimation.reqFrameAni(_main.stockView["stockView" + (i + 1)]["allocAni" + (j + 1)], _allocAniCom);
				}
			}
			trace("_allocTotal = ", _allocTotal);
			if (_allocTotal == 0){
				dispatchEvent(new Event(Event.COMPLETE));
			}
		}
		private function _allocAniCom():void
		{
			_allocComCnt++;
			if (_allocComCnt == _allocTotal){
				dispatchEvent(new Event(Event.COMPLETE));
			}
		}
	}
}