package bgs.game.control.sequence
{
	import flash.events.Event;
	import flash.utils.setTimeout;
	
	import bgs.game.control.user.PlayerControl;
	import bgs.game.define.Game;
	import bgs.game.define.Ment;
	import bgs.game.define.Stock;
	import bgs.game.event.BuyEvent;
	import bgs.game.event.StockEvent;
	import bgs.game.model.StockModel;
	import bgs.game.util.Align;
	import bgs.game.view.ChangeStockPop;
	import bgs.game.view.RulePop;
	import bgs.game.view.SelStockPop;
	import bgs.game.vo.StockChangeVO;

	public class Sell extends SequenceBase
	{
		private var _selectView:SelStockPop;
		private var _showRuleView:RulePop;
		private var _changeStockView:ChangeStockPop;
		private var _tempStock:Vector.<uint>;
		private var _addStepStock:Vector.<uint>;
		private var _selectArr:Vector.<uint>;
		
		public function Sell(main:Main)
		{
			super(main);
		}
		
		private function _exeSelPop():void
		{
			_main.popupMc.visible = true;
			_main.popupMc.gotoAndStop(Game.SELL_SEL_POPUP_FRAME);
			
			_selectView = new SelStockPop(_main.popupMc);
			_selectView.addEventListener(BuyEvent.BUY_SELECT_COMPLETE, _handleSellCom);
		}
		
		private function _exeRulePop():void
		{
			_showRuleView = new RulePop(_main.popupMc);
			
			_main.popupMc.visible = true;
			_main.popupMc.gotoAndStop(Game.RULE_SELL_VIEW_POPUP_FRAME);
			
			_showRuleView.start();
			_showRuleView.addEventListener(BuyEvent.BUY_RULE_CLOSE, _handleRuleCom);
		}
		private function _exeChangeStock():void
		{
			_changeStockView = new ChangeStockPop(_main.popupMc);
			_main.popupMc.visible = true;
			_main.popupMc.gotoAndStop(Game.MARKER_VIEW_POPUP_FRAME);
			_changeStockView.start(_addStepStock, _tempStock, ChangeStockPop.SELL_MODE);
			_changeStockView.addEventListener(Event.COMPLETE, _handleChangeViewCom);
		}
		private function _acceptStock():void
		{
			var stockModel:StockModel = StockModel.getInstance();
			var stockData:Vector.<uint> = stockModel.stock;
			
			for (var i:uint = 0; i < _addStepStock.length; i++){
				stockData[i] = stockModel.stock[i] - _addStepStock[i] * Stock.STOCK_MOVE_STEP[i];			
			}
			stockModel.stock = stockData;
			
			PlayerControl.getInstance().acceptSellStock();
			stockModel.addEventListener(StockEvent.CHANGE_ANI_COM, _stockAniCom);
			//			setTimeout(_nextStep, Game.TEXT_BALLOON_TURM);
		}
		private function _stockAniCom(e:StockEvent):void
		{
			StockModel.getInstance().removeEventListener(StockEvent.CHANGE_ANI_COM, _stockAniCom);
			_nextStep();
		}
		override protected function _setStep():void
		{
			var mentIndex:int = -1;
			switch(_step){
				case 0:
					mentIndex = 0;
					// 0번째 맨트 실행 진행, 끝나면 이벤트 처리
					break;
				case 1:
					mentIndex = 1;
					// 1번째 맨트 실행 진행, 끝나면 이벤트 처리
					break;
				case 2:
					_exeSelPop();
					// 맨트 비노출, 팝업 실행, 주식 선택 인터렉션
					break;
				case 3:
					mentIndex = 2;
					// 2 주가 변동 규칙 확인 맨트
					break;
				case 4:
					if (_isFirst == true){
						_exeRulePop();
					}
					// 주가 변동 규칙 확인 보여줌. 닫기 이벤트 확인
					break;
				case 5:
					mentIndex = 3;
					// 3 제출한 마커 확인 맨트
					break;
				case 6:
					_exeChangeStock();
					// 확인 팝업 노출. 닫기 이벤트 확인
					break;
				case 7:
					mentIndex = 4;
					// 4 각 회사의 주가 변동 사항을 확인 맨트
					break;
				case 8:
					_acceptStock();
					// 주가 변동 에니메이션
					break;
				case 9:
					mentIndex = 5;
					// 5 매수하는 맨트, 에니메이션
					break;
				case 10:
					mentIndex = 6;
					
					// 6 완료 맨트
					break;
				default:
					_complete();
					return;
			}
			if (_isFirst == false){
				var a:Array = [0, 0, 1, 0, 0, 0, 1, 0, 1, 0, 0];
				if (a[_step] == 0){
					_nextStep();
					return;
				}
			}
			if (mentIndex === -1){
				_main.mentTxt.visible = _main.balloonMc.visible = false;
			}else{
				
				_main.mentTxt.visible = _main.balloonMc.visible = true;
				_main.mentTxt.text = Ment.SELL_MENTS[mentIndex];				
				Align.textVAlign(_main.mentTxt, Game.TALK_BALLOON_RECT.y, Game.TALK_BALLOON_RECT.height);
				setTimeout(_nextStep, Game.TEXT_BALLOON_TURM);
			}
		}
		private function _complete():void
		{
			_main.popupMc.gotoAndStop(Game.BLANK_POPUP_FRAME);
			dispatchEvent(new Event(Event.COMPLETE));
		}
		//======================================================================
		// event handlers
		//======================================================================
		
		private function _handleChangeViewCom(e:Event):void
		{
			_main.popupMc.visible = false;
			_changeStockView.removeEventListener(Event.COMPLETE, _handleChangeViewCom);
			_changeStockView = null;
			
			_nextStep();
		}
		private function _handleRuleCom(e:BuyEvent):void
		{
			_main.popupMc.visible = false;
			_showRuleView.removeEventListener(BuyEvent.BUY_RULE_CLOSE, _handleRuleCom);
			_showRuleView = null;
			_nextStep();
		}
		private function _handleSellCom(e:BuyEvent):void
		{
			var vo:StockChangeVO = PlayerControl.getInstance().sell(e.data as Vector.<uint>);
			_addStepStock = vo.moves;
			_tempStock = vo.nums;
			_main.popupMc.visible = false;
			_selectView.removeEventListener(BuyEvent.BUY_SELECT_COMPLETE, _handleSellCom);
			_selectView = null;
			_nextStep();
		}
	}
}