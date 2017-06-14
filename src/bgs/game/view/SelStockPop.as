package bgs.game.view
{
	import flash.display.MovieClip;
	import flash.events.EventDispatcher;
	import flash.events.MouseEvent;
	
	import bgs.game.define.Game;
	import bgs.game.define.SndDef;
	import bgs.game.event.BuyEvent;
	import bgs.game.vo.OptionPare;

	public class SelStockPop extends EventDispatcher
	{
		private var _popup:MovieClip;
		private var _optBtns:Vector.<OptionPare>;
		private var _checkTotal:uint = 0;
		public function SelStockPop(popup:MovieClip)
		{
			_popup = popup;
			
			_checkTotal = 0;
			
			_initOptionBtns();
			_attachEvents();
		}
		
		private function _initOptionBtns():void
		{
			var btn1:MovieClip;
			var btn2:MovieClip;
			_optBtns = new Vector.<OptionPare>;
			for (var i:uint = 1; i <= 4; i++){
				btn1 = _popup["option" + i + "_1"]
				btn2 = _popup["option" + i + "_2"];
				btn1.gotoAndStop(2);
				btn2.gotoAndStop(2);
				
				_optBtns.push(new OptionPare(btn1, btn2));
			}
		}
		
		private function _checkClickNum(pare:OptionPare):uint
		{
			var returnNum:uint = 0;
			if (pare.btn1.currentFrame == 1)
			{
				returnNum++;
			}
			if (pare.btn2.currentFrame == 1)
			{
				returnNum++;
			}
			
			return returnNum;
		}
		
		private function _attachEvents():void
		{
			var len:uint = _optBtns.length;
			var opPare:OptionPare;
			
			for (var i:uint = 0; i < len; i++){
				opPare = _optBtns[i];
				opPare.btn1.addEventListener(MouseEvent.MOUSE_DOWN, _handleClickToggle);
				opPare.btn2.addEventListener(MouseEvent.MOUSE_DOWN, _handleClickToggle);
			}
			_popup.submit.addEventListener(MouseEvent.CLICK, _handleSubmit);
		}
		
		private function _handleSubmit(e:MouseEvent):void
		{
			SndDef.play(SndDef.SND1_ID, 1);
			var arr:Vector.<uint> = new Vector.<uint>;
			var len:uint = _optBtns.length;
			
			for (var i:uint = 0; i < len; i++)
			{
				arr.push(_checkClickNum(_optBtns[i]));
			}
			
			dispatchEvent(new BuyEvent(BuyEvent.BUY_SELECT_COMPLETE, arr));
		}
		
		private function _handleClickToggle(e:MouseEvent):void
		{
			SndDef.play(SndDef.SND1_ID, 1);
			var btn:MovieClip = e.currentTarget as MovieClip;
			if (btn.currentFrame == 2){
				if (_checkTotal < Game.MAX_SELL_MARKER){
					btn.gotoAndStop(1);
					_checkTotal++;
				}
			}else{
				btn.gotoAndStop(2);
				_checkTotal--;
			}
		}
	}
}