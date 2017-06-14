package bgs.game.vo
{
	public class StockChangeVO
	{
		private var _moves:Vector.<uint>;
		private var _nums:Vector.<uint>;
		
		public function StockChangeVO(nums:Vector.<uint>, moves:Vector.<uint>)
		{
			_nums = nums;
			_moves = moves;
		}
		
		public function get nums():Vector.<uint>{
			return _nums;
		}
		public function get moves():Vector.<uint>{
			return _moves;
		}
	}
}