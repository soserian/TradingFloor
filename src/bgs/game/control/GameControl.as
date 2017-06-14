package bgs.game.control
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.MouseEvent;
	import flash.text.TextFieldAutoSize;
	
	import bgs.game.control.game.DiceControl;
	import bgs.game.control.game.StockControl;
	import bgs.game.control.sequence.SeqManager;
	import bgs.game.control.user.PlayerControl;
	import bgs.game.define.Game;
	import bgs.game.define.SndDef;
	import bgs.game.define.StockTiles;
	import bgs.game.event.StockTileEvent;
	import bgs.game.model.GameModel;
	import bgs.game.model.StockTileModel;
	import bgs.game.view.ChangeTileView;
	import bgs.game.view.PreparePop;
	import bgs.game.vo.Tile;

	public class GameControl extends EventDispatcher
	{
		private var _main:Main;
//		private var _user:Player;
//		private var _pc:PC;
		private var _seqManager:SeqManager;
		private var _prepareView:PreparePop;
		private var _stockControl:StockControl;
		private var _diceControl:DiceControl;
		private var _gameModel:GameModel;
		private var _playerControl:PlayerControl;
		private var _viewControl:ViewControl;
//		private var _changeStockView:ChangeStockView;
//		private var _changeDividend:ChangeDividend;
		
		
		//======================================================
		// constructor
		//======================================================
		
		public function GameControl(main:Main)
		{
			_main = main;
		}
		
		//======================================================
		// public
		//======================================================
		public function startGame():void
		{
			_initializeGame();
			_startReady();
		}
		
		
		public function dispose():void
		{
			_main.xBtn.removeEventListener(MouseEvent.CLICK, _handleClose);
		}
		
		//======================================================
		// private
		//======================================================
		private function _initializeGame():void
		{
			_setInit();
			_attachEvent();
//			_createPlayers();
			_createSeq();
			_createControls();
			_initUI();
		}
		
		private function _createControls():void
		{
			// TODO Auto Generated method stub
			_stockControl = new StockControl(_main);
			_diceControl = new DiceControl;
			_playerControl = new PlayerControl;
		}
		
		private function _initUI():void
		{
			var stockView:MovieClip;
			for (var i:uint = 1; i <= 4; i++)
			{
				stockView = _main.stockView["stockView" + i];
				stockView.graph.arrow.rotaion = 0;
				for (var j:uint = 1; j <= 4; j++){
					stockView["alloc" + j].gotoAndStop(1);
					stockView["allocAni" + j].gotoAndStop(1);
				}
			}
			for(i = 1; i <= 4; i++)
			{
				_main["marker" + i + "_1"].gotoAndStop(i);
				_main["marker" + i + "_2"].gotoAndStop(i);;
			}
		}
		private function _startReady():void
		{
			_prepareView = new PreparePop(_main.readyPopup);
			_prepareView.start();
			_prepareView.addEventListener(StockTileEvent.TILE_CHANGE, _generateTiles);
			_prepareView.addEventListener(Event.COMPLETE, _prepareCom);
		}
		private function _prepareCom(e:Event):void
		{
			_startSeq();
		}
		private function _startSeq():void
		{
//			_gameModel.isFirst = false;
			_gameModel.round = 1;
			_gameModel.state = 0;
			_roundView(_seqManager.start);
		}
		
		private function _roundView(callback:Function):void
		{
			var enterFrame:Function = function(e:Event):void{
				_main.roundView.nextFrame();
				if (_main.roundView.currentFrame == _main.roundView.totalFrames){
					_main.removeEventListener(Event.ENTER_FRAME, enterFrame);
					_main.roundView.visible = false;
					callback();
				}
			}
			_main.roundView.visible = true;
			_main.roundView.gotoAndStop(1);
			
			_main.roundView.textMc.roundTxt.text = _gameModel.round + "Round Start";
			_main.addEventListener(Event.ENTER_FRAME, enterFrame);
		}
		private function _setInit():void
		{
			_main.gotoAndStop(2);
			_main.popupMc.gotoAndStop(1);
			_main.readyPopup.gotoAndStop(1);
			
			_main.mentTxt.visible = false;
			_main.balloonMc.visible = false;
			_main.popupMc.visible = false;
			_main.readyPopup.visible = false;
			_main.eventCardView.visible = false;
			_main.userCard.visible = false;
			_main.userECard.visible = false;
			_main.currCard.visible = false;
			_main.nextCard.visible = false;
			_main.roundView.visible = false;
			_main.tileAni.visible = false;
			_main.stockView.gotoAndStop(1);
			_main.subTitleView.gotoAndStop(1);
			_main.tileFirstAni.gotoAndStop(1);
			_main.roundView.gotoAndStop(1);
			_main.tileAni.gotoAndStop(1);
			for(var i:uint = 1; i <= 4; i++)
			{
				_main["marker" + i + "_1"].visible = false;
				_main["marker" + i + "_2"].visible = false;
			}
			
			_main.mentTxt.wordWrap = true;
			_main.mentTxt.autoSize = TextFieldAutoSize.CENTER;
			_viewControl = ViewControl.getInstance();
			_viewControl.changeTileView = new ChangeTileView(_main);
			_gameModel = GameModel.getInstance();
		}
		
		private function _generateTiles(e:Event):void
		{
			_prepareView.removeEventListener(StockTileEvent.TILE_CHANGE, _generateTiles);
			
			var stockTileModel:StockTileModel = StockTileModel.getInstance();
			var total:uint = StockTiles.TOTAL_CARDS;
			var arr:Array = [];
			var genArr:Vector.<Tile> = new Vector.<Tile>;
			for (var i:uint = 0; i < total; i++){
				arr.push(i);
			}
			for (i = 0; i < total; i++){
				genArr.push(new Tile(arr.splice(Math.random() * arr.length | 0, 1)));
			}
			
			stockTileModel.tileSeqArr = genArr;
			
			stockTileModel.selIndex = 0;
			_viewControl.changeTileView.firstChange();
		}
		
//		private function _createPlayers():void
//		{
//			_user = Player.getInstance();
//			_pc = PC.getInstance();
//			_user.init();
//			_pc.init();
//		}
		
		private function _createSeq():void
		{
			_seqManager = new SeqManager(_main);
			_seqManager.addEventListener(Event.COMPLETE, _nextRound);
		}
		
		private function _attachEvent():void
		{
			_main.xBtn.addEventListener(MouseEvent.CLICK, _handleClose);
		}
		//======================================================
		// event
		//======================================================
		private function _nextRound(e:Event):void
		{
			_gameModel.isFirst = false;
			if (_gameModel.round == Game.TOTAL_ROUND){
				_main.popupMc.visible = true;
				_main.popupMc.gotoAndStop(Game.RESULT_POPUP_FRAME);
				return;
			}
			_gameModel.round++;
			_gameModel.state = 0;
			
			_main.roundTxt.text = _gameModel.round + "Round";
			
			_roundView(_seqManager.nextRound);
//			_seqManager.nextRound();
		}
		private function _handleClose(e:MouseEvent):void
		{
			SndDef.play(SndDef.SND1_ID, 1);
			dispatchEvent(new Event(Event.CLOSE));
		}
	}
}