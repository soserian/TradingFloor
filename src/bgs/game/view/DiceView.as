package bgs.game.view
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.MouseEvent;
	
	import bgs.game.define.Game;
	import bgs.game.define.SndDef;
	import bgs.game.event.DiceEvent;

	public class DiceView extends EventDispatcher
	{
		private var _popup:MovieClip;
		private var _resultNum:uint;
		public function DiceView(popup:MovieClip)
		{
			_popup = popup;
		}
		public function init():void
		{
			_popup.gotoAndStop(Game.DO_DICE_POPUP_FRAME);
			_popup.visible = true;
			_popup.doDice.visible = true;
			_popup.xBtn.visible = false;
			_popup.diceMc.gotoAndStop(1);
			_popup.diceMc.dice.gotoAndStop(1);
			_attachEvent();
		}
		private function _attachEvent():void
		{
			_popup.xBtn.addEventListener(MouseEvent.CLICK, _handleClose);
			_popup.doDice.addEventListener(MouseEvent.CLICK, _handleDice);
		}
		private function _startDice():void
		{
			_popup.addEventListener(Event.ENTER_FRAME, _diceAni);
		}
		private function _diceAni(e:Event):void
		{
			_popup.diceMc.nextFrame();
			if (_popup.diceMc.currentFrame == _popup.diceMc.totalFrames){
				_popup.diceMc.gotoAndStop(1);
				_resultNum = (Math.random() * 6 | 0) + 1;
				_popup.diceMc.dice.gotoAndStop(6 - _resultNum + 1);
				_popup.removeEventListener(Event.ENTER_FRAME, _diceAni);
				_diceCom();
			}
		}
		private function _diceCom():void
		{
			_popup.xBtn.visible = true;
		}
		private function _handleClose(e:MouseEvent):void
		{
			SndDef.play(SndDef.SND1_ID, 1);
			if (_resultNum){
				_popup.xBtn.removeEventListener(MouseEvent.CLICK, _handleClose);
				_popup.doDice.removeEventListener(MouseEvent.CLICK, _handleDice);
				dispatchEvent(new DiceEvent(DiceEvent.DICE_VIEW_COM, _resultNum));
			} else {
				// 주사위를 굴리지 않으면 안되게끔
			}
			
		}
		private function _handleDice(e:MouseEvent):void
		{
			SndDef.play(SndDef.SND1_ID, 1);
			_popup.doDice.visible = false;
			_popup.doDice.removeEventListener(MouseEvent.CLICK, _handleDice);
			_startDice();
		}
	}
}