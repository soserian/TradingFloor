package bgs.game.view
{
	import flash.display.MovieClip;
	import flash.events.EventDispatcher;
	import flash.events.MouseEvent;
	
	import bgs.game.define.SndDef;
	import bgs.game.event.BuyEvent;

	public class RulePop extends EventDispatcher
	{
		private var _popup:MovieClip;
		public function RulePop(popup:MovieClip)
		{
			_popup = popup;
			
		}
		
		private function _attachEvent():void
		{
			_popup.confirmMc.addEventListener(MouseEvent.CLICK, _handleClose);
		}
		
		private function _handleClose(e:MouseEvent):void
		{
			SndDef.play(SndDef.SND1_ID, 1);
			_popup.confirmMc.removeEventListener(MouseEvent.CLICK, _handleClose);
			dispatchEvent(new BuyEvent(BuyEvent.BUY_RULE_CLOSE));
		}
		
		public function start():void
		{
			_attachEvent();	
		}
	}
}