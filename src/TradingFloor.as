package
{
	import bgs.game.control.EntryControl;
	import bgs.game.control.GameControl;
//	
	import flash.display.Sprite;
	import flash.events.Event;
	
	[SWF(width="1200", height="840")]
	public class TradingFloor extends Sprite
	{
		private var main:Main;
		private var entryControl:EntryControl;
		private var gameControl:GameControl;
		
		public function TradingFloor()
		{
			addEventListener(Event.ADDED_TO_STAGE, initialize);
		}
		
		protected function initialize(event:Event):void
		{
			createMain();
			setControl();
		}
		
		private function setControl():void
		{
			entryControl = new EntryControl(main);
			gameControl = new GameControl(main);
			
			entryControl.addEventListener(Event.CLOSE, handleCloseGame);
			entryControl.addEventListener(Event.OPEN, handleOpenGame);
			entryControl.startEntry();
		}		
		
		protected function handleOpenGame(event:Event):void
		{
			gameControl.startGame();
		}
		protected function handleCloseGame(event:Event):void
		{
			gameControl.dispose();
			entryControl.startEntry();
		}
		
		private function createMain():void
		{
			main = new Main;
			main.gotoAndStop(1);
			addChild(main);
		}
	}
}