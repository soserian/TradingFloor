package bgs.game.control.sequence
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.MouseEvent;
	import flash.utils.setTimeout;
	
	import bgs.game.define.Game;
	import bgs.game.event.DiceEvent;
	import bgs.game.event.StockEvent;
	import bgs.game.model.GameModel;
	import bgs.game.model.StockModel;
	import bgs.game.view.DiceView;

	public class StockChange extends EventDispatcher implements IGameControl
	{
		private var _main:Main;
		private var _diceView:DiceView;
		public function StockChange(main:Main)
		{
			_main = main;
		}
		
		public function start():void
		{
			_diceView = new DiceView(_main.popupMc);
			_diceView.addEventListener(DiceEvent.DICE_VIEW_COM, _handleDice);
			_diceView.init();
		}
		
		private function _handleDice(e:DiceEvent):void
		{
			_main.popupMc.visible = false;
			GameModel.getInstance().dice = e.data;
			
			StockModel.getInstance().addEventListener(StockEvent.CHANGE_ANI_COM, _changeCom);
		}
		private function _changeCom(e:StockEvent):void
		{
			StockModel.getInstance().removeEventListener(StockEvent.CHANGE_ANI_COM, _changeCom);
			if (GameModel.getInstance().isFirst == true){
				setTimeout(function():void{
					_main.popupMc.gotoAndStop(Game.DIV_INFO_POPUP_FRAME);
					_main.popupMc.visible = true;
					_main.popupMc.xBtn.addEventListener(MouseEvent.CLICK, _handleClose);
				}, 1000);
			} else {				
				_handleClose(null);
			}
		}
		
		private function _handleClose(e:MouseEvent):void
		{
			_main.popupMc.visible = false;
			setTimeout(_complete, 1000);
		}
		private function _complete():void
		{
			_main.popupMc.gotoAndStop(Game.BLANK_POPUP_FRAME);
			dispatchEvent(new Event(Event.COMPLETE));
		}
	}
}