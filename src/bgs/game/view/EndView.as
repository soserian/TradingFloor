package bgs.game.view
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.MouseEvent;
	
	import bgs.game.model.PlayerModel;
	import bgs.game.model.StockModel;
	
	public class EndView extends EventDispatcher
	{
		private var _popup:MovieClip;
		
		public function EndView(popup:MovieClip)
		{
			_popup = popup;
		}
		
		public function setView():void
		{
			var stockModel:StockModel = StockModel.getInstance();
			var playerModel:PlayerModel = PlayerModel.getInstance();
			
//			stockModel.
			
			_popup.confirmBtn.addEventListener(MouseEvent.CLICK, _handleConfirm);
		}
		private function _handleConfirm(e:MouseEvent):void
		{
			// 종료 후 처리 어떻게 할 지...
			dispatchEvent(new Event(Event.COMPLETE));
		}
	}
}