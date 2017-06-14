package bgs.game.control
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.MouseEvent;
	
	import bgs.game.define.SndDef;

	public class EntryControl extends EventDispatcher
	{
		private var _main:Main;
		public function EntryControl(main:Main)
		{
			_main = main;
		}
		
		public function startEntry():void
		{
			prepareSetting();
		}
		
		private function prepareSetting():void
		{
			_main.preparePopupMc.gotoAndStop(1);
			_main.preparePopupMc.visible = false;
			attachMouseEvents();
		}
		
		private function attachMouseEvents():void
		{
			_main.preparePopupMc.xBtn.addEventListener(MouseEvent.CLICK, handleXClick);
			_main.preparePopupMc.prevBtn.addEventListener(MouseEvent.CLICK, handlePrevClick);
			_main.preparePopupMc.nextBtn.addEventListener(MouseEvent.CLICK, handleNextClick);
			
			_main.startBtn.addEventListener(MouseEvent.CLICK, handleStartClick);
			_main.helpBtn.addEventListener(MouseEvent.CLICK, handleHelpClick);
		}
		
		private function detachMouseEvents():void
		{
			_main.preparePopupMc.xBtn.removeEventListener(MouseEvent.CLICK, handleXClick);
			_main.preparePopupMc.prevBtn.removeEventListener(MouseEvent.CLICK, handlePrevClick);
			_main.preparePopupMc.nextBtn.removeEventListener(MouseEvent.CLICK, handleNextClick);
			
			_main.startBtn.removeEventListener(MouseEvent.CLICK, handleStartClick);
			_main.helpBtn.removeEventListener(MouseEvent.CLICK, handleHelpClick);
		}
		
		protected function handleXClick(e:MouseEvent):void
		{
			SndDef.play(SndDef.SND1_ID, 1);
			_main.preparePopupMc.visible = false;
		}
		protected function handlePrevClick(e:MouseEvent):void
		{
			SndDef.play(SndDef.SND1_ID, 1);
			_main.preparePopupMc.prevFrame();
		}
		protected function handleNextClick(e:MouseEvent):void
		{
			SndDef.play(SndDef.SND1_ID, 1);
			_main.preparePopupMc.nextFrame();
		}
		protected function handleStartClick(e:MouseEvent):void
		{
			SndDef.play(SndDef.SND1_ID, 1);
			detachMouseEvents();
			dispatchEvent(new Event(Event.OPEN));
		}
		protected function handleHelpClick(e:MouseEvent):void
		{
			SndDef.play(SndDef.SND1_ID, 1);
			_main.preparePopupMc.gotoAndStop(1);
			_main.preparePopupMc.visible = true;
		}
	}
}