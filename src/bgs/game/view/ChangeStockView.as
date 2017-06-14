package bgs.game.view
{
	import com.greensock.TweenMax;
	import com.greensock.easing.Sine;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	import bgs.game.define.Stock;
	import bgs.game.model.StockModel;
	import bgs.game.util.FrameAnimation;

	public class ChangeStockView extends EventDispatcher
	{
		private var _main:Main;
		private var _stockModel:StockModel;
		private var _aniCom:uint = 0;
		public function ChangeStockView(main:Main)
		{
			_main = main;
		}
		
		public function init():void
		{
			_stockModel = StockModel.getInstance();
		}
		public function changeAni():void
		{
			FrameAnimation.reqFrameAni(_main.stockView, _stockAni);
		}
		private function _stockAni():void
		{
			var stock:Vector.<uint>;
			_aniCom = 0;
			stock = _stockModel.stock.slice(0);
			for (var i:uint = 0; i < stock.length; i++){
				TweenMax.to(_main.stockView["stockView" + (i + 1)].graph.arrow, 1.2, {rotation:Stock.STEP_ANGLE * (stock[i] - Stock.DEFUALT_STOCK[i]) / Stock.STOCK_MOVE_STEP[i], ease:Sine.easeInOut, onComplete: _handleAniCom});
				//				_main["stockView" + (i + 1)].graph.arrow.rotation = Stock.STEP_ANGLE * (stock[i] - Stock.DEFUALT_STOCK[i]) / Stock.STOCK_MOVE_STEP[i];
			}
		}
		private function _handleAniCom():void
		{
			_aniCom++;
			if (_aniCom == _stockModel.stock.length){
				dispatchEvent(new Event(Event.COMPLETE));
			}
		}
	}
}