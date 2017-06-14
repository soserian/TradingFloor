package bgs.game.control.sequence
{
	import flash.events.Event;
	import flash.utils.setTimeout;
	
	import bgs.game.define.Game;
	import bgs.game.define.Ment;
	import bgs.game.util.Align;
	import bgs.game.view.SelEventCard;

	public class EventCard extends SequenceBase
	{
		private var _eventCard:SelEventCard;
		
		public function EventCard(main:Main)
		{
			super(main);
		}
		
		//======================================================================
		// public
		//======================================================================
		
		
		//======================================================================
		// priavete
		//======================================================================
		
		private function _exeSelEventCard():void
		{
			_eventCard = new SelEventCard(_main);
			_eventCard.addEventListener(Event.COMPLETE, _handleEventCom);
			_eventCard.start();
			
//			setTimeout(function():void{
//				_eventCard.init();
//				_nextStep();
//			}, Game.TEXT_BALLOON_TURM);
		}
		override protected function _setStep():void
		{
			var mentIndex:int = -1;
			switch(_step){
				case 0:
					mentIndex = 0;
					// 0번째 맨트 실행 진행, 끝나면 이벤트 처리
					_exeSelEventCard();
					break;
				case 1:
					if (_isFirst){						
						mentIndex = 1;
						setTimeout(_nextStep, Game.TEXT_BALLOON_TURM);
					}else{
						_nextStep();
					}
					// 1번째 맨트 실행 진행, 끝나면 이벤트 처리
					break;
				default:
					_complete();
			}
			if (mentIndex === -1){
				_main.mentTxt.visible = _main.balloonMc.visible = false;
			}else{
				if (_isFirst){
					_main.mentTxt.visible = _main.balloonMc.visible = true;
					_main.mentTxt.text = Ment.EVENT_MENTS[mentIndex];
				}
			}
			Align.textVAlign(_main.mentTxt, Game.TALK_BALLOON_RECT.y, Game.TALK_BALLOON_RECT.height);
		}
		private function _complete():void
		{
			_main.popupMc.gotoAndStop(Game.BLANK_POPUP_FRAME);
			dispatchEvent(new Event(Event.COMPLETE));
		}
		private function _handleEventCom(e:Event):void
		{
			if (_main.userECard.visible == false){			
				_main.userECard.visible = true;
			}else{
				_main.userECard.num.nextFrame();				
			}
			_eventCard.init();
			_nextStep();
		}
	}
}