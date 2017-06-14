package bgs.game.view
{
	import com.greensock.TimelineMax;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	import bgs.game.model.StockTileModel;
	import bgs.game.util.FrameAnimation;

	public class ChangeTileView extends EventDispatcher
	{
		private var _main:Main;
		private var _stockTileModel:StockTileModel;
		public function ChangeTileView(main:Main)
		{
			_main = main;
			_stockTileModel = StockTileModel.getInstance();
		}
		public function firstChange():void
		{
			var timeline:TimelineMax = new TimelineMax;
			timeline.to(_main.currCard, .5, {scaleY: 0, onComplete: _setCurrTile})
				.to(_main.currCard, .5, {scaleY: 1});
			var timeline2:TimelineMax = new TimelineMax;
			timeline2.to(_main.nextCard, .5, {delay: .5, scaleY: 0, onComplete: _setNextTile})
				.to(_main.nextCard, .5, {scaleY: 1});
		}
		
		public function nextChange():void
		{
			_main.tileAni.gotoAndStop(1);
			_main.tileAni.oldTile.gotoAndStop(_main.currCard.currentFrame);
			_main.tileAni.currTile.gotoAndStop(_main.nextCard.currentFrame);
			_main.tileAni.nextTile.gotoAndStop(1);
			_main.currCard.visible = false;
			_main.nextCard.visible = false;
			_setCurrTile();
			_setNextTile();
			_main.tileAni.visible = true;
			FrameAnimation.reqFrameAni(_main.tileAni, _nextAni);
		}
		
		private function _nextAniCom():void
		{
			_main.currCard.visible = _main.nextCard.visible = true;
			_main.tileAni.visible = false;
			dispatchEvent(new Event(Event.COMPLETE));
		}
		
		private function _nextAni():void
		{
			var timeline:TimelineMax = new TimelineMax({onComplete: _nextAniCom});
			timeline.to(_main.tileAni.nextTile, .5, {delay: .5, scaleY: 0, onComplete: _setAniNextTile})
				.to(_main.tileAni.nextTile, .5, {scaleY: 1});
		}
		
		private function _setCurrTile():void
		{
			_main.currCard.gotoAndStop(_stockTileModel.currentTile.index + 2);
		}
		
		private function _setNextTile():void
		{
			_main.nextCard.gotoAndStop(_stockTileModel.nextTile.index + 2);
		}
		
		private function _setAniNextTile():void
		{
			_main.tileAni.nextTile.gotoAndStop(_stockTileModel.nextTile.index + 2);
		}
	}
}