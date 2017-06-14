package bgs.game.control.sequence
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	import bgs.game.model.GameModel;
	import bgs.game.util.FrameAnimation;

	/**
	 * 게임 절차를 순차적으로 실행하도록 감독하는 역할을 한다.
	 **/
	public class SeqManager extends EventDispatcher
	{
		private var _gameModel:GameModel;
		private var _gamePool:Vector.<IGameControl>;
		private var _game:IGameControl;
		private var _main:Main;
		
		public function SeqManager(main:Main)
		{
			_main = main;
			_gameModel = GameModel.getInstance();
		}
		
		public function start():void
		{
//			_gameModel.state = 2;
			_initPool();
			_progressGame();
		}
		public function nextRound():void
		{
			_progressGame();
		}
		public function nextStart():void
		{
			_main["step" + (_gameModel.state + 1)].gotoAndPlay('off');
			_gameModel.state++;
			if (_gameModel.state == _gamePool.length){
				dispatchEvent(new Event(Event.COMPLETE));
				return;
			}
			_progressGame();
		}

		private function _initPool():void
		{
			// TODO: 생성 시 공통으로 필요한 파라미터를 넘겨준다. Main이라던지..
			_gamePool = new <IGameControl>[new Buy(_main), new Sell(_main), new EventCard(_main), new StockChange(_main), new StockChangeTile(_main)]
		}
		private function _progressGame():void
		{
			if (_game){
				_detachEvent();
			}
			_main.subTitleView.gotoAndStop(1);
			_main.subTitleView.subTitle.gotoAndStop(_gameModel.state + 1);
			FrameAnimation.reqFrameAni(_main.subTitleView, _nextGame);
		}
		private function _nextGame():void
		{
			_game = _gamePool[_gameModel.state];
			_main["step" + (_gameModel.state + 1)].gotoAndPlay('on');
			_attachEvent();
			_game.start();
		}
		private function _attachEvent():void
		{
			_game.addEventListener(Event.COMPLETE, _nextSeq);
		}
		private function _detachEvent():void
		{
			_game.removeEventListener(Event.COMPLETE, _nextSeq);
		}
		
		private function _nextSeq(e:Event):void
		{
			nextStart();
		}
	}
}