package bgs.game.view
{
	import com.greensock.TimelineMax;
	import com.greensock.TweenMax;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	import bgs.game.define.SndDef;

	public class SelEventCard extends EventDispatcher
	{
		private var _main:Main;
		private var _initPos:Point = new Point(1145, 420);
		private var _zoomPos:Point = new Point(1108, 420);
		private var _zoomScale:Number = 2;
		private var _cardNum:uint;
		public function SelEventCard(main:Main)
		{
			_main = main;
		}
		
		public function init():void
		{
			_main.eventCardView.visible = false;
			_main.eventCardView.useBtn.visible = true;
			_main.eventCardView.saveBtn.visible = true;
			_cardInit();
		}
		
		public function start():void
		{
			var tl:TimelineMax = new TimelineMax({onComplete: function():void{
				_main.eventCard.addEventListener(MouseEvent.CLICK, _handleClick);
			}});
			
			tl.to(_main.eventCard, 0.3, {scaleX: 0, onComplete:function():void{
				_createCard();
			}});
			tl.to(_main.eventCard, 0.3, {scaleX: 1});
			tl.to(_main.eventCard, 0.3, {x: _zoomPos.x, y:_zoomPos.y, scaleX: _zoomScale, scaleY: _zoomScale, onComplete: function():void{
				_main.eventCard.addEventListener(MouseEvent.CLICK, _handleClick);
			}});
//			_main.eventCard.x = _zoomPos.x;
//			_main.eventCard.y = _zoomPos.y;
//			_main.eventCard.scaleX = _main.eventCard.scaleY = _zoomScale;
			
			
		}
		private function _cardInit():void
		{
			_main.eventCard.gotoAndStop(1);
			_main.eventCard.x = _initPos.x;
			_main.eventCard.y = _initPos.y;
			_main.eventCard.scaleX = _main.eventCard.scaleY = 1;
		}
		private function _createCard():void
		{
			_cardNum = (Math.random() * 5 | 0) + 1;
			_main.eventCard.gotoAndStop(_cardNum + 1);
		}
		private function _handleClick(e:MouseEvent):void
		{
			SndDef.play(SndDef.SND1_ID, 1);
			_main.eventCard.removeEventListener(MouseEvent.CLICK, _handleClick);
			_cardInit();
			_main.eventCardView.eventCard.gotoAndStop(_cardNum + 1);
			_main.eventCardView.visible = true;
			_attachEvent();
		}
		private function _handleUse(e:MouseEvent):void
		{
			SndDef.play(SndDef.SND1_ID, 1);
//			_detachEvent();
		}
		private function _handleSave(e:MouseEvent):void
		{
			SndDef.play(SndDef.SND1_ID, 1);
			_detachEvent();
			_main.eventCardView.useBtn.visible = false;
			_main.eventCardView.saveBtn.visible = false;
			TweenMax.to(_main.eventCardView, 0.3, {x: 703, y:754, scaleX: .2, scaleY: .2, onComplete: function():void{
				_main.eventCardView.visible = false;
				_main.eventCardView.x = 925;
				_main.eventCardView.y = 233;
				_main.eventCardView.scaleX = _main.eventCardView.scaleY = 1;
				
				dispatchEvent(new Event(Event.COMPLETE));
			}});	
		}
		
		
		private function _attachEvent():void
		{
			_main.eventCardView.useBtn.addEventListener(MouseEvent.CLICK, _handleUse);
			_main.eventCardView.saveBtn.addEventListener(MouseEvent.CLICK, _handleSave);
		}
		private function _detachEvent():void
		{
			_main.eventCardView.useBtn.removeEventListener(MouseEvent.CLICK, _handleUse);
			_main.eventCardView.saveBtn.removeEventListener(MouseEvent.CLICK, _handleSave);
		}
	}
}