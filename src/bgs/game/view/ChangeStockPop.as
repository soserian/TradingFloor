package bgs.game.view
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.MouseEvent;
	
	import bgs.game.define.SndDef;

	public class ChangeStockPop extends EventDispatcher
	{
		private var _popup:MovieClip;
		private const yPos:Vector.<int> = new <int>[-114, -31, 51, 131];
		private const startX:int = -20;
		private const stepX:int = -40;
		private var _blocks:Array;
		static public const SELL_MODE:String = "sell";
		static public const BUY_MODE:String = "buy";
		public function ChangeStockPop(popup:MovieClip)
		{
			_popup = popup;
		}
		
		public function start(addArr:Vector.<uint>, tempArr:Vector.<uint>, mode:String):void
		{
			_blocks = [];
			for (var i:uint = 0; i < addArr.length; i++){
				_popup["stockChgTxt" + (i + 1)].gotoAndStop(addArr[i] == 0 ? 1 : addArr[i] + (mode == BUY_MODE ? 1 : 5));
				setBlocks(i, tempArr[i]);
			}
			
			_popup.confirmMc.addEventListener(MouseEvent.CLICK, _handleClick);
		}
		private function _handleClick(e:MouseEvent):void
		{
			SndDef.play(SndDef.SND1_ID, 1);
			for (var i:uint = 0; i < _blocks.length; i++){
				_popup.removeChild(_blocks[i]);
			}
			_popup.confirmMc.removeEventListener(MouseEvent.CLICK, _handleClick);
			dispatchEvent(new Event(Event.COMPLETE));
		}
		private function setBlocks(index:uint, total:uint):void
		{
			var block:Block;
			for (var i:uint = 0; i < total; i++){
				block = new Block;
				block.gotoAndStop(index + 1);
				block.x = startX + i * stepX;
				block.y = yPos[index];
				block.scaleY = block.scaleX = 0.5;
				_blocks.push(block);
				
				_popup.addChild(block);
			}
		}
	}
}