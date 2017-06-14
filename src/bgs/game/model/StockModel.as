package bgs.game.model
{
	import flash.events.EventDispatcher;
	
	import bgs.game.define.Stock;
	import bgs.game.event.StockEvent;

	public class StockModel extends EventDispatcher
	{
		static private var _stockModel:StockModel;
		private var _stockData:Vector.<uint>;
		private var _dividendData:Vector.<uint>;
		public function StockModel()
		{
			_stockData = Stock.DEFUALT_STOCK.slice(0);
			_dividendData = new <uint>[0, 0, 0, 0];
		}
		static public function getInstance():StockModel
		{
			if (!_stockModel)
			{
				_stockModel = new StockModel;
			}
			
			return _stockModel;
		}
		public function set dividend(d:Vector.<uint>):void
		{
			_dividendData = d;
		}
		public function get dividend():Vector.<uint>
		{
			return _dividendData;
		}
		
		public function set stock(s:Vector.<uint>):void
		{
			_stockData = s;
			dispatchEvent(new StockEvent(StockEvent.CHANGE, _stockData));
		}
		public function get stock():Vector.<uint>
		{
			return _stockData;
		}
		
//		public function setStockData(index:uint, data:uint):void
//		{
//			if (_stockData[index] === data){
//				return;
//			}
//			
//			_stockData[index] = data;
//			
//		}
		
		public function setDividendData(index:uint, data:uint):void
		{
			_dividendData[index] = data;
		}
	}
}