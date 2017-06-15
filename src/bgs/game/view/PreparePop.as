package bgs.game.view
{
	import com.greensock.TweenMax;
	import com.greensock.easing.Back;
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.MouseEvent;
	import flash.utils.setTimeout;
	
	import bgs.game.control.user.PlayerControl;
	import bgs.game.define.SndDef;
	import bgs.game.event.StockTileEvent;
	import bgs.game.util.FrameAnimation;

	public class PreparePop extends EventDispatcher
	{
		private var _popup:MovieClip;
		private var _main:Main;
		private var _tween:TweenMax;
		private var _names:Vector.<String> = new <String>[
			"user", "pc1", "pc2", "pc3", 
		];
		private var _cnt:uint = 0;
		private var _comCnt:uint = 0;
		private const ANI_TERM:uint = 1000;
		public function PreparePop(popup:MovieClip)
		{
			_popup = popup;
			_main = _popup.parent as Main;
		}
		
		public function start():void
		{
			var money:MovieClip;
			_popup.gotoAndStop(1);
//			_popup.xBtn.addEventListener(MouseEvent.CLICK, _xClick);
			_initAni();
			for (var i:uint = 1; i <= 5; i++){
				money = _main["money" + i];
				money.gotoAndStop(i);
				money.visible = false;
			}
			_progress(_popup.currentFrame);
			_attachEvent();
			_popup.visible = true;
		}
		private function _initAni():void
		{
			for (var i:uint = 0; i < _names.length; i++){
				_init(_names[i]);
			}
		}
		private function _init(name:String):void
		{
			var mc:MovieClip = _main.prepareAni[name] as MovieClip;
			mc.card.gotoAndStop(1);
			mc.money.gotoAndStop(1);
		}
		private function _endClick(e:MouseEvent):void
		{
			SndDef.play(SndDef.SND1_ID, 1);
			_popup.visible = false;
			dispatchEvent(new Event(Event.COMPLETE));
		}
		private function _next(e:MouseEvent):void
		{
			SndDef.play(SndDef.SND1_ID, 1);
			_detachEvent();
			
			_popup.nextFrame();
			
			if (_popup.currentFrame == _popup.totalFrames)
			{
				_popup.endBtn.addEventListener(MouseEvent.CLICK, _endClick);
			}
			else
			{
				_progress(_popup.currentFrame);
				_attachEvent();				
			}
		}
		private function _progress(step:uint):void
		{
			if (_tween){
				_tween.totalProgress(1).kill();
				_tween = null;
			}
			_popup.nextBtn.visible = false;
			switch(step){
				case 1:
					setTimeout(function():void{
						for (var i:uint = 1; i <= 4; i++){					
							_aniView(_main["marker" + i + "_1"]);
							_aniView(_main["marker" + i + "_2"], function():void{
								_popup.nextBtn.visible = true;
							});
						}
					}, 1000);
					
					break;
				case 2:
					_cnt = 0;
					_comCnt = 0;
					_aniCard();
					break;
				case 3:
					_cnt = 0;
					_comCnt = 0;
					_aniMoney();
					
					break;
				case 4:
					_main.prepareAni.visible = false;
//					_popup.nextBtn.visible = true;
					_aniTile();
//					_main.currCard.visible = true;
//					_main.nextCard.visible = true;
//					_aniView(_main.currCard);
//					_aniView(_main.nextCard, function():void{
						
//					});
					
					break;
				case 5:
					break;
			}
		}
		private function _aniTile():void
		{
			FrameAnimation.reqFrameAni(_main.tileFirstAni, _tileAniCom);
		}
		private function _cardActive():void
		{
			_initAni();
			for (var i:uint = 1; i <= 4; i++){
				_main.userCard["card" + i].gotoAndStop(i);
				_main.userCard["cardNum" + i].gotoAndStop(2);
			}
			
			_main.userCard.visible = true;
			_popup.nextBtn.visible = true;
		}
		private function _moneyActive():void
		{
			_initAni();
			PlayerControl.getInstance().initCash();
			_popup.nextBtn.visible = true;
			for (var i:uint = 1; i <= 5; i++){
				_main["money" + i].visible = true;
			}
		}
		
		private function _tileAniCom():void
		{
			_main.tileFirstAni.visible = false;
			_main.currCard.visible = true;
			_main.nextCard.visible = true;
			_popup.nextBtn.visible = true;
			dispatchEvent(new StockTileEvent(StockTileEvent.TILE_CHANGE));
		}
		private function _cardAniCom():void
		{
			_comCnt++;
			
			if (_comCnt == _cnt){
				_cardActive();
//				_popup.nextFrame();
//				_progress(_popup.currentFrame);
			}
		}
		private function _moneyAniCom():void
		{
			_comCnt++;
			if (_comCnt == _cnt){
				_moneyActive();
//				_popup.nextFrame();
//				_progress(_popup.currentFrame);
			}
		}
		private function _aniCard():void
		{
			var card:MovieClip = _main.prepareAni[_names[_cnt]].card;
			card.gotoAndStop(1);
			
			FrameAnimation.reqFrameAni(card, _cardAniCom);
			_cnt++;
			if (_cnt < _names.length){			
				setTimeout(_aniCard, ANI_TERM);
			}
		}
		private function _aniMoney():void
		{
			var money:MovieClip = _main.prepareAni[_names[_cnt]].money;
			money.gotoAndStop(1);
			FrameAnimation.reqFrameAni(money, _moneyAniCom);
			_cnt++;
			if (_cnt < _names.length){
				setTimeout(_aniMoney, ANI_TERM);
			}else{
				
			}
		}
		private function _aniView(mc:MovieClip, callback:Function = null):void
		{
			mc.alpha = 0;
			mc.scaleX = mc.scaleY = 3;
			mc.visible = true;
			_tween = TweenMax.to(mc, 1.5, {scaleX: 0.35, scaleY: 0.35, alpha:1, onComplete:callback, ease:Back.easeOut});
		}
		
//		private function _prev(e:MouseEvent):void
//		{
//			SndDef.SND1.play(1);
//			_detachEvent();
//			
//			_popup.prevFrame();
//			
//			_attachEvent();			
//		}
		private function _detachEvent():void
		{
			if (_popup.nextBtn){				
				_popup.nextBtn.removeEventListener(MouseEvent.CLICK, _next);
			}
//			if (_popup.prevBtn){			
//				_popup.prevBtn.removeEventListener(MouseEvent.CLICK, _prev);
//			}
		}
		private function _attachEvent():void
		{
			if (_popup.nextBtn){
				_popup.nextBtn.addEventListener(MouseEvent.CLICK, _next);
			}
//			if (_popup.prevBtn){			
//				_popup.prevBtn.addEventListener(MouseEvent.CLICK, _prev);
//			}
		}
	}
}