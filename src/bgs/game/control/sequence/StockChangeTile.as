package bgs.game.control.sequence
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.utils.setTimeout;
	
	import bgs.game.control.ViewControl;
	import bgs.game.define.Game;
	import bgs.game.define.Ment;
	import bgs.game.model.StockTileModel;

	public class StockChangeTile extends EventDispatcher implements IGameControl
	{
		private var _main:Main;
		private var _stockTileModel:StockTileModel;
		public function StockChangeTile(main:Main)
		{
			_main = main;
			_stockTileModel = StockTileModel.getInstance();
		}
		
		public function start():void
		{
			_viewText();
			_changeTile();
			setTimeout(_complete, 1000);
		}
		private function _complete():void
		{
			_main.popupMc.gotoAndStop(Game.BLANK_POPUP_FRAME);
			dispatchEvent(new Event(Event.COMPLETE));
		}
		private function _viewText():void
		{
			_main.mentTxt.visible = _main.balloonMc.visible = true;
			_main.mentTxt.text = Ment.TILE_MENTS[0];
		}
		
		private function _changeTile():void
		{
			_stockTileModel.selIndex++;
			ViewControl.getInstance().changeTileView.nextChange();
//			_main.currCard.gotoAndStop(_stockTileModel.currentTile.index + 2);
//			_main.nextCard.gotoAndStop(_stockTileModel.nextTile.index + 2);
		}
	}
}