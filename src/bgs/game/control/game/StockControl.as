package bgs.game.control.game
{
	import flash.events.Event;
	
	import bgs.game.event.StockEvent;
	import bgs.game.model.StockModel;
	import bgs.game.util.FrameAnimation;
	import bgs.game.view.ChangeDividend;
	import bgs.game.view.ChangeStockView;

	public class StockControl
	{
		private var _changeStockView:ChangeStockView;
		private var _changeDividend:ChangeDividend;
		private var _stockModel:StockModel;
		private var _main:Main;
		public function StockControl(main:Main)
		{
			_main = main;
			_init();
		}
		
		private function _init():void
		{
			_stockModel = StockModel.getInstance();
			_createStockView();
			_attachEvent();
		}
		
		private function _createStockView():void
		{
			_changeStockView = new ChangeStockView(_main);
			_changeStockView.init();
			_changeDividend = new ChangeDividend(_main);
			_changeDividend.init();
		}
		
		private function _attachEvent():void
		{
			_stockModel.addEventListener(StockEvent.CHANGE, _changeStock);
		}
		
		private function _changeStock(e:StockEvent):void
		{
			_changeStockView.addEventListener(Event.COMPLETE, _handleChangeStockCom);
			_changeStockView.changeAni();
		}
		private function _handleChangeStockCom(e:Event):void
		{
			_changeDividend.addEventListener(Event.COMPLETE, _stockChangeCom);
			_changeDividend.changeAni();
			
			_changeStockView.removeEventListener(Event.COMPLETE, _handleChangeStockCom);
		}
		private function _stockChangeCom(e:Event):void
		{
			_changeDividend.removeEventListener(Event.COMPLETE, _stockChangeCom);
			FrameAnimation.reqFrameAni(_main.stockView, _allComplete, true);
		}
		private function _allComplete():void
		{
			_stockModel.dispatchEvent(new StockEvent(StockEvent.CHANGE_ANI_COM));
		}
	}
}